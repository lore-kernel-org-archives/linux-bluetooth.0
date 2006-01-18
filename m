Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <51809.199.118.135.220.1137617728.squirrel@www.blisster.com>
Subject: Re: [Bluez-users] Logitech Bluetooth Travel Mouse on Sony VAIO t370
From: "Robert Bliss" <rbliss@blisster.com>
To: <bluez-users@lists.sourceforge.net>
In-Reply-To: <1137616238.7000.24.camel@localhost>
References: <51698.199.118.135.220.1137612095.squirrel@www.blisster.com>
        <1137616238.7000.24.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Wed, 18 Jan 2006 15:55:28 -0500 (EST)

Thanks I assume what you meant by that is to change my hcid.conf from
security none to security auto cause that seems to make it work.

  I needed to manually modprobe hci_usb, and hidp and manually start
hidd --server.

  What is the best way to have this all atomatically start up?

   Thanks
     Bob

> Hi Robert,
>
>>   I am trying to get a Logitech Bluetooth Travel Mouse to work on a
>> Sony
>> VAIO T370 laptop.
>
> try it again without setting yourself into security mode 3.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files for problems?  Stop!  Download the new AJAX search engine that
> makes searching your log files as easy as surfing the  web.  DOWNLOAD
> SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
