Return-Path: <cyrus@holtmann.org>
Message-ID: <4E7B0DBF.7060406@tieto.com>
Date: Thu, 22 Sep 2011 12:28:15 +0200
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Johan
 Hedberg <johan.hedberg@gmail.com>, "padovan@profusion.mobi"
	<padovan@profusion.mobi>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix possible NULL pointer dereference
References: <20110921070804.GA5982@elgon.mountain>	 <1316671092-4387-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <1316685104.1937.120.camel@aeonflux>
In-Reply-To: <1316685104.1937.120.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

>>   	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,&ev->bdaddr);
>> -	if (conn&&  conn->state == BT_CONNECTED) {
>> -		hci_conn_hold(conn);
>> -		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
>> -		hci_conn_put(conn);
>> -	}
>> +	if (conn) {
>
> what is from with this:
>
> 	if (!conn)
> 		goto unlock;
>

Well, the file is mixed in style, thus I chose the style as for nearby 
functions. Anyway, if this form is preferable let me know and will update.

/Waldek
