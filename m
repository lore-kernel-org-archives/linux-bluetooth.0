Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418137907-16981-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1418137907-16981-5-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 9 Dec 2014 16:37:03 +0100
Message-ID: <CAMudyAuW_cT6_kTDPVddjaQsTEAtedf9Qg5_REYOgTubvC8yXw@mail.gmail.com>
Subject: Re: [PATCH 04/25] android/hog: Minor coding style fixes
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 9 December 2014 at 16:11, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> ---
>  android/hog.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/android/hog.c b/android/hog.c
> index edee73f..872f4a5 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -221,7 +221,8 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
>  static void external_report_reference_cb(guint8 status, const guint8 *pdu,
>                                         guint16 plen, gpointer user_data);
>
> -static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
> +static void discover_external_cb(uint8_t status, GSList *descs,
> +                                                       void *user_data)
>  {
>         struct bt_hog *hog = user_data;
>
> @@ -253,7 +254,8 @@ static void discover_external(GAttrib *attrib, uint16_t start, uint16_t end,
>                                                                 user_data);
>  }
>
> -static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
> +static void discover_report_cb(uint8_t status, GSList *descs,
> +                                                       void *user_data)
>  {
>         struct report *report = user_data;
>         struct bt_hog *hog = report->hog;
> @@ -399,7 +401,8 @@ static int report_cmp(gconstpointer a, gconstpointer b)
>         return ra->id - rb->id;
>  }
>
> -static struct report *find_report(struct bt_hog *hog, uint8_t type, uint8_t id)
> +static struct report *find_report(struct bt_hog *hog, uint8_t type,
> +                                                               uint8_t id)
>  {
>         struct report cmp;
>         GSList *l;
> @@ -499,8 +502,8 @@ done:
>                 error("bt_uhid_send: %s", strerror(-err));
>  }
>
> -static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
> -                                                               bool *is_long)
> +static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen,
> +                                               ssize_t *len, bool *is_long)
>  {
>         if (!blen)
>                 return false;
> @@ -696,7 +699,8 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                 DBG("HoG is operating in Report Protocol Mode");
>  }
>
> -static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
> +static void char_discovered_cb(uint8_t status, GSList *chars,
> +                                                               void *user_data)
>  {
>         struct bt_hog *hog = user_data;
>         struct gatt_primary *primary = hog->primary;
> @@ -827,13 +831,16 @@ void bt_hog_unref(struct bt_hog *hog)
>         if (!hog)
>                 return;
>
> +       DBG("ref %d", hog->ref_count - 1);
> +
>         if (__sync_sub_and_fetch(&hog->ref_count, 1))
>                 return;
>
>         hog_free(hog);
>  }
>
> -static void find_included_cb(uint8_t status, GSList *services, void *user_data)
> +static void find_included_cb(uint8_t status, GSList *services,
> +                                                       void *user_data)
>  {
>         struct bt_hog *hog = user_data;
>         struct gatt_included *include;
> @@ -881,7 +888,8 @@ static void find_included_cb(uint8_t status, GSList *services, void *user_data)
>                                                 char_discovered_cb, hog);
>  }
>
> -static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
> +static void hog_attach_scpp(struct bt_hog *hog,
> +                                               struct gatt_primary *primary)
>  {
>         if (hog->scpp) {
>                 bt_scpp_attach(hog->scpp, hog->attrib);
> --
> 1.8.4
>

Seems like this patch can be ignored. Looks like my editor just
incorrectly shows me 80 bound. It does not take font width into
account correctly.
Thanks Szymon for pointing it out. Hope that other patches are not
broked due to this.

\Lukasz
