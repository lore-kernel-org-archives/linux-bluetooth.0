Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343428380-32705-5-git-send-email-vinicius.gomes@openbossa.org>
References: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
	<1343428380-32705-5-git-send-email-vinicius.gomes@openbossa.org>
Date: Fri, 27 Jul 2012 18:52:27 -0400
Message-ID: <CAJdJm_MJM3AKu6Rrir+WkwyeyoEezjjvqQY2E14bzcUSz2NcXw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] Bluetooth: Refactor ACL connection into its own function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jul 27, 2012 at 6:32 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> The hci_connect() function was starting to get too complicated to be
> quickly understood. We can separated the creation of a new ACL

small typo: separated -> separate

> connection into its own function.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 0a74399..1d70e9f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -497,18 +497,10 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>         return le;
>  }
>
> -/* Create SCO, ACL or LE connection.
> - * Device _must_ be locked */
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -                            __u8 dst_type, __u8 sec_level, __u8 auth_type)
> +static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> +                                               u8 sec_level, u8 auth_type)
>  {
>         struct hci_conn *acl;
> -       struct hci_conn *sco;
> -
> -       BT_DBG("%s dst %s", hdev->name, batostr(dst));
> -
> -       if (type == LE_LINK)
> -               return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
>
>         acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
>         if (!acl) {
> @@ -526,6 +518,26 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>                 hci_acl_create_connection(acl);
>         }
>
> +       return acl;
> +}
> +
> +/* Create SCO, ACL or LE connection.
> + * Device _must_ be locked */
> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> +                            __u8 dst_type, __u8 sec_level, __u8 auth_type)
> +{
> +       struct hci_conn *acl;
> +       struct hci_conn *sco;
> +
> +       BT_DBG("%s dst %s", hdev->name, batostr(dst));
> +
> +       if (type == LE_LINK)
> +               return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
> +
> +       acl = hci_connect_acl(hdev, dst, sec_level, auth_type);
> +       if (IS_ERR(acl))
> +               return acl;
> +
>         if (type == ACL_LINK)
>                 return acl;

Does it make sense to merge the two if()'s above into one? i.e.:

if (IS_ERR(acl) || type == ACL_LINK)
    return acl;

It's still clear, IMHO.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
