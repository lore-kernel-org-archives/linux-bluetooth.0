Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
References: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 17 Oct 2014 10:14:04 +0200
Message-ID: <CABBYNZKio2G-PDPyusQ0Pzrt-vcxtOGJt5pSYCU4JbJV6xit1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] android/avrcp-lib: Add status parameter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 13, 2014 at 11:55 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds status parameter for functions generating browsing reponses
> as it may not be possible to respond synchronously using the return of
> the callback while processing the request.
> ---
>  android/avrcp-lib.c | 91 ++++++++++++++++++++++++++++-------------------------
>  android/avrcp-lib.h | 16 +++++-----
>  unit/test-avrcp.c   | 13 ++++----
>  3 files changed, 64 insertions(+), 56 deletions(-)
>
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index b7d0f5e..f3cdab9 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -3337,6 +3337,20 @@ int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
>                                 &iov, 1);
>  }
>
> +static int avrcp_status_rsp(struct avrcp *session, uint8_t transaction,
> +                                               uint8_t pdu_id, uint8_t status)
> +{
> +       struct iovec iov;
> +
> +       if (status > AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED)
> +               return -EINVAL;
> +
> +       iov.iov_base = &status;
> +       iov.iov_len = sizeof(status);
> +
> +       return avrcp_send_browsing(session, transaction, pdu_id, &iov, 1);
> +}
> +
>  int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
>                                         uint8_t status, uint16_t counter,
>                                         uint32_t items, uint8_t depth,
> @@ -3347,13 +3361,9 @@ int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
>         uint16_t len[UINT8_MAX];
>         int i;
>
> -       if (status != AVRCP_STATUS_SUCCESS) {
> -               iov[0].iov_base = &status;
> -               iov[0].iov_len = sizeof(status);
> -               return avrcp_send_browsing(session, transaction,
> -                                               AVRCP_SET_BROWSED_PLAYER,
> -                                               iov, 1);
> -       }
> +       if (status != AVRCP_STATUS_SUCCESS)
> +               return avrcp_status_rsp(session, transaction,
> +                                       AVRCP_SET_BROWSED_PLAYER, status);
>
>         rsp.status = status;
>         put_be16(counter, &rsp.counter);
> @@ -3390,16 +3400,20 @@ int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
>  }
>
>  int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t counter, uint8_t number,
> -                                       uint8_t *type, uint16_t *len,
> -                                       uint8_t **params)
> +                                       uint8_t status, uint16_t counter,
> +                                       uint8_t number, uint8_t *type,
> +                                       uint16_t *len, uint8_t **params)
>  {
>         struct iovec iov[UINT8_MAX * 2 + 1];
>         struct get_folder_items_rsp rsp;
>         uint8_t item[UINT8_MAX][3];
>         int i;
>
> -       rsp.status = AVRCP_STATUS_SUCCESS;
> +       if (status != AVRCP_STATUS_SUCCESS)
> +               return avrcp_status_rsp(session, transaction,
> +                                       AVRCP_GET_FOLDER_ITEMS, status);
> +
> +       rsp.status = status;
>         put_be16(counter, &rsp.counter);
>         put_be16(number, &rsp.number);
>
> @@ -3422,12 +3436,16 @@ int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
>  }
>
>  int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
> -                                                               uint32_t items)
> +                                               uint8_t status, uint32_t items)
>  {
>         struct iovec iov;
>         struct change_path_rsp rsp;
>
> -       rsp.status = AVRCP_STATUS_SUCCESS;
> +       if (status != AVRCP_STATUS_SUCCESS)
> +               return avrcp_status_rsp(session, transaction, AVRCP_CHANGE_PATH,
> +                                                                       status);
> +
> +       rsp.status = status;
>         put_be32(items, &rsp.items);
>
>         iov.iov_base = &rsp;
> @@ -3477,12 +3495,9 @@ int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
>         if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
>                 return -EINVAL;
>
> -       if (status != AVRCP_STATUS_SUCCESS) {
> -               iov[0].iov_base = &status;
> -               iov[0].iov_len = sizeof(status);
> -               return avrcp_send_browsing(session, transaction,
> -                                       AVRCP_GET_ITEM_ATTRIBUTES, iov, 1);
> -       }
> +       if (status != AVRCP_STATUS_SUCCESS)
> +               return avrcp_status_rsp(session, transaction,
> +                                       AVRCP_GET_ITEM_ATTRIBUTES, status);
>
>         rsp.status = status;
>         rsp.number = number;
> @@ -3498,27 +3513,24 @@ int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
>                                         number * 2 + 1);
>  }
>
> -int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction)
> +int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction,
> +                                                               uint8_t status)
>  {
> -       struct iovec iov;
> -       struct play_item_rsp rsp;
> -
> -       rsp.status = AVRCP_STATUS_SUCCESS;
> -
> -       iov.iov_base = &rsp;
> -       iov.iov_len = sizeof(rsp);
> -
> -       return avrcp_send_browsing(session, transaction, AVRCP_PLAY_ITEM,
> -                                                               &iov, 1);
> +       return avrcp_status_rsp(session, transaction, AVRCP_PLAY_ITEM,
> +                                                               status);
>  }
>
> -int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
> +int avrcp_search_rsp(struct avrcp *session, uint8_t transaction, uint8_t status,
>                                         uint16_t counter, uint32_t items)
>  {
>         struct iovec iov;
>         struct search_rsp rsp;
>
> -       rsp.status = AVRCP_STATUS_SUCCESS;
> +       if (status != AVRCP_STATUS_SUCCESS)
> +               return avrcp_status_rsp(session, transaction, AVRCP_SEARCH,
> +                                                               status);
> +
> +       rsp.status = status;
>         put_be16(counter, &rsp.counter);
>         put_be32(items, &rsp.items);
>
> @@ -3529,18 +3541,11 @@ int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
>                                                                 &iov, 1);
>  }
>
> -int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction)
> +int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction,
> +                                                               uint8_t status)
>  {
> -       struct iovec iov;
> -       struct add_to_now_playing_rsp rsp;
> -
> -       rsp.status = AVRCP_STATUS_SUCCESS;
> -
> -       iov.iov_base = &rsp;
> -       iov.iov_len = sizeof(rsp);
> -
> -       return avrcp_send_browsing(session, transaction,
> -                                       AVRCP_ADD_TO_NOW_PLAYING, &iov, 1);
> +       return avrcp_status_rsp(session, transaction, AVRCP_ADD_TO_NOW_PLAYING,
> +                                                               status);
>  }
>
>  int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> index 9985c4a..2299c83 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -327,17 +327,19 @@ int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
>                                         uint32_t items, uint8_t depth,
>                                         const char **folders);
>  int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t counter, uint8_t number,
> -                                       uint8_t *type, uint16_t *len,
> -                                       uint8_t **params);
> +                                       uint8_t status, uint16_t counter,
> +                                       uint8_t number, uint8_t *type,
> +                                       uint16_t *len, uint8_t **params);
>  int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
> -                                                               uint32_t items);
> +                                               uint8_t status, uint32_t items);
>  int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
>                                         uint8_t status, uint8_t number,
>                                         uint32_t *attrs, const char **text);
> -int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction);
> -int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
> +int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction,
> +                                       uint8_t status);
> +int avrcp_search_rsp(struct avrcp *session, uint8_t transaction, uint8_t status,
>                                         uint16_t counter, uint32_t items);
> -int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction);
> +int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction,
> +                                                               uint8_t status);
>
>  int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 154175e..a6a1872 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -719,8 +719,8 @@ static int get_folder_items(struct avrcp *session, uint8_t transaction,
>         if (start > 1)
>                 return -ERANGE;
>
> -       avrcp_get_folder_items_rsp(session, transaction, 0xabcd, 0, NULL, NULL,
> -                                                                       NULL);
> +       avrcp_get_folder_items_rsp(session, transaction, AVRCP_STATUS_SUCCESS,
> +                                               0xabcd, 0, NULL, NULL, NULL);
>
>         return -EAGAIN;
>  }
> @@ -734,7 +734,7 @@ static int change_path(struct avrcp *session, uint8_t transaction,
>         if (!uid)
>                 return -ENOTDIR;
>
> -       avrcp_change_path_rsp(session, transaction, 0);
> +       avrcp_change_path_rsp(session, transaction, AVRCP_STATUS_SUCCESS, 0);
>
>         return -EAGAIN;
>  }
> @@ -768,7 +768,7 @@ static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
>         if (!uid)
>                 return -ENOENT;
>
> -       avrcp_play_item_rsp(session, transaction);
> +       avrcp_play_item_rsp(session, transaction, AVRCP_STATUS_SUCCESS);
>
>         return -EAGAIN;
>  }
> @@ -778,7 +778,7 @@ static int search(struct avrcp *session, uint8_t transaction,
>  {
>         DBG("");
>
> -       avrcp_search_rsp(session, transaction, 0xaabb, 0);
> +       avrcp_search_rsp(session, transaction, AVRCP_STATUS_SUCCESS, 0xaabb, 0);
>
>         return -EAGAIN;
>  }
> @@ -792,7 +792,8 @@ static int add_to_now_playing(struct avrcp *session, uint8_t transaction,
>         if (!uid)
>                 return -ENOENT;
>
> -       avrcp_add_to_now_playing_rsp(session, transaction);
> +       avrcp_add_to_now_playing_rsp(session, transaction,
> +                                                       AVRCP_STATUS_SUCCESS);
>
>         return -EAGAIN;
>  }
> --
> 1.9.3

I went ahead and push this set.


-- 
Luiz Augusto von Dentz
