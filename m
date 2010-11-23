Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290535889-17038-2-git-send-email-dmitriy.paliy@nokia.com>
References: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
	<1290535889-17038-2-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 23 Nov 2010 23:07:28 +0200
Message-ID: <AANLkTinNTKdL6wQwi3gC+D4zW9X31St7MB+-mDJAuPkA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Add phonebook request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 23, 2010 at 8:11 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> Add phonebook request structure to phonebook-tracker and pointer to
> pending call in PBAP object.
> ---
>  plugins/pbap.c              |    1 +
>  plugins/phonebook-tracker.c |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/pbap.c b/plugins/pbap.c
> index 1a7d001..3264e85 100644
> --- a/plugins/pbap.c
> +++ b/plugins/pbap.c
> @@ -147,6 +147,7 @@ struct pbap_session {
>  struct pbap_object {
>        GString *buffer;
>        struct pbap_session *session;
> +       void *request;
>  };
>
>  static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 20053f6..afe0f2f 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -1035,6 +1035,10 @@ struct phonebook_index {
>        int index;
>  };
>
> +struct phonebook_req {
> +       DBusPendingCall *call;
> +};

No need to create a struct here, you can pass the call since there is
not other members.

-- 
Luiz Augusto von Dentz
Computer Engineer
