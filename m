Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4d5d2589.8f7edc0a.5af6.27dd@mx.google.com>
References: <4d5d2589.8f7edc0a.5af6.27dd@mx.google.com>
Date: Thu, 17 Feb 2011 14:59:31 -0300
Message-ID: <AANLkTinc+MpZGp2B2dYrn2vmmHevaHgMtkevFPT6=+q-@mail.gmail.com>
Subject: Re: [RFCv2 3/4] Bluetooth: Use ERR_PTR to return error from hci_connect
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

On Thu, Feb 17, 2011 at 10:39 AM,  <anderson.briglia@openbossa.org> wrote:
> @@ -472,8 +474,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>        acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
>        if (!acl) {
>                acl = hci_conn_add(hdev, ACL_LINK, dst);
> -               if (!acl)
> -                       return NULL;
> +               if (IS_ERR(acl))
> +                       return acl;
>        }

Note that if you follow Gustavo's suggestion to keep hci_conn_add()
returning NULL on ENOMEM, you should change this as well:

if (!acl)
    return ERR_PTR(-ENOMEM);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
