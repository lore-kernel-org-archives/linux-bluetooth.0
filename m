Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 10:14:16 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/7] Bluetooth: Refactor SCO connection into its own
 function
Message-ID: <20120816071414.GA24160@aemeltch-MOBL1>
References: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
 <1343428380-32705-6-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343428380-32705-6-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jul 27, 2012 at 07:32:58PM -0300, Vinicius Costa Gomes wrote:
...
> -/* Create SCO, ACL or LE connection.
> - * Device _must_ be locked */
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
> +static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, bdaddr_t *dst,
> +				     u8 sec_level, u8 auth_type)

Here we use u8

...
> +/* Create SCO, ACL or LE connection. */
> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> +			     __u8 dst_type, __u8 sec_level, __u8 auth_type
...

and here __u8

Shall we agree about those type usage, I thought that we use __u* in
headers and u* in c-files. At least in one file we shall use one type.

Best regards 
Andrei Emeltchenko 

