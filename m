Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Definition of hci_conn_info_req
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <94e407f00512020254pb83407ds7fec44efaaca1385@mail.gmail.com>
References: <94e407f00512020222g42375059h491249e313cea536@mail.gmail.com>
	 <1133519615.11226.13.camel@blade>
	 <94e407f00512020254pb83407ds7fec44efaaca1385@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133521311.11226.41.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 02 Dec 2005 12:01:51 +0100

Hi Arpit,

> > no, it is not.
> 
> What does hci_conn_info_req do then?Any documentation anywhere?I'm
> kinda lost with all the Bluez code.

you can get information about the current established connections.

> > Depends on how you convert the address. Use ba2str().
> 
> Yes I'm using ba2str to convert.My question is, should &cr->bdaddr
> contain the address of the remote bluetooth device? 
> 
>     char add[18];
>     struct hci_conn_info_req *cr;   
>     cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>     bacpy( &cr->bdaddr, &bdaddr );
>     ba2str( &bdaddr, add);
>     printf("Bluetooth address-remote device: %s \n", add);
>     cr->type = ACL_LINK;
> 
> Everytime I run the executable C, I get a different value for
> &cr->bdaddr. 

Where does bdaddr come from?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
