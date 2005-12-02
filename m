Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Definition of hci_conn_info_req
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
Cc: eng11084@nus.edu.sg
In-Reply-To: <94e407f00512020222g42375059h491249e313cea536@mail.gmail.com>
References: <94e407f00512020222g42375059h491249e313cea536@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133519615.11226.13.camel@blade>
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
Date: Fri, 02 Dec 2005 11:33:35 +0100

Hi Arpit,

> Another basic question.The statement below is a request to establish
> connection with a remote device,right?

no, it is not.

> struct hci_conn_info_req *cr;
> cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
> 
> Now,is &cr->bdaddr supposed to be the remote device bluetooth address?
> 
> When I convert this value to string and output it, it doesn't give me
> the correct value for the remote bluetooth device. It returns
> 08:04:9A:AC:00:00. Doesn't make sense to me.

Depends on how you convert the address. Use ba2str().

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
