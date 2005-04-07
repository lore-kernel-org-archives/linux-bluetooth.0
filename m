Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] rejecting or accepting connection request
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <11D888B5FA88D9409851B71E8D3206D1016632@doar.commil.com>
References: <11D888B5FA88D9409851B71E8D3206D1016632@doar.commil.com>
Content-Type: text/plain
Message-Id: <1112892118.9047.94.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 07 Apr 2005 18:41:58 +0200

Hi Tzahi,
 
> +	if ( IsUserAppPolicy==1 )
> +	{
> +		BT_DBG("%s Connection request: %s letting the app decide
> if to accept or reject", hdev->name);
> +		return;
> +	}
> +		

I don't think that I will add this part of your patch, because I have
plans for a policy manager.
 	
>  	conn = conn_hash_lookup_ba(hdev, cc->link_type, &cc->bdaddr);
> -	if (!conn) {
> -		hci_dev_unlock(hdev);
> -		return;
> +	if (!conn) 
> +	{
> +		if (!(conn = hci_conn_add(hdev, cc->link_type,
> &cc->bdaddr))) 
> +		{
> +			BT_ERR("No memmory for new connection");
> +			hci_dev_unlock(hdev);
> +			return;
> +		}

This part is not so unhandy to have it anyway, but you forgot to think
about what this change means if the ev->status is not zero.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
