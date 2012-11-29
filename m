Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Nov 2012 11:31:49 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/4] Bluetooth: Set link parameters for outgoing connections
Message-ID: <20121129093147.GA2574@aemeltch-MOBL1>
References: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1354127316-17431-5-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1354127316-17431-5-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Nov 28, 2012 at 07:28:36PM +0100, Frédéric Dalleau wrote:
> In order to establish the connection, the outgoing connection must also
> request the codec. Here we need to set a bit in ACL connection flag to set up
> the correct parameters if the ACL connection is not up yet.

...

> @@ -585,7 +586,8 @@ void hci_chan_list_flush(struct hci_conn *conn);
>  struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
>  
>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
> +			     __u8 dst_type, __u8 sec_level,
> +			     __u8 auth_type, __u8 codec);

somehow I do not like this new parameter for hci_connect as it is only
needed for SCO.

Now I am not sure we need hci_connect super-function if it only calls
appropriate hci_connect_{sco,acl,le} based on type.

...
> @@ -552,7 +559,8 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
>  }
>  
>  static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
> -				bdaddr_t *dst, u8 sec_level, u8 auth_type)
> +					bdaddr_t *dst, u8 sec_level,
> +					u8 auth_type, u8 codec)

what about directly calling hci_connect_sco with the parameter?

...

Best regards 
Andrei Emeltchenko 

