Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W14FB0463308C709A1DFDEAC0800@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 13 Nov 2007 02:03:45 +0000
In-Reply-To: <d89ddf300711121024x48b98b92h183fd6b1a1b50849@mail.gmail.com>
References: <BAY117-W20475FC961A6D4564AA606C0870@phx.gbl>
	<d89ddf300711121024x48b98b92h183fd6b1a1b50849@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Does Bluez3.22 support SPP?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0898286921=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0898286921==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Brad:


     Yes,i've found that python-dbus package you mentioned.Since im using
montavista on ARM9 platform, i cross-compiled dbus-python-0.82.3 instead of
directly using the python-dbus package. Right now i can use the demo script
"test-serial" in /bluez-utils-3.22/serial.

$ ./test-serial
hcid[825]: /org/bluez: org.bluez.Manager.ActivateService()
Usage: ./test-serial  [service]

The script seems to be running fine.
Although i can't connect to any real bluetooth SPP device cause my GPS
module hasn't arrived yet...


Anyway, i still have 2 questions:

1.There are 2 methods u mentioned that i use on SPP: rfcomm.conf and dbus.
So how do i make use of rfcomm.conf to get SPP running?

Here's my current rfcomm.conf:
************************************
#
# RFCOMM configuration file.
#

rfcomm0 {
     # Automatically bind the device at startup
     bind no;

     # Bluetooth address of the device
     device 00:0D:3C:EB:53:F0;

     # RFCOMM channel for the connection
     channel     1;

     # Description of the connection
     comment "Example Bluetooth device";
}
*************************************
Is there anything wrong/needs to be changed?

Also, it seems i can use python script to get SPP running by the dbus
method...??(im not familiar with python :-(   )


2.Im still not very clear about the functionality of
"bluetoothd-serivce-serial" daemon.
  i read a little about the code of /bluez-utils-3.22/serial/main.c and i
guess maybe it does the following things?

 Register the serial service
 accept any incoming spp connection

Is that right/all?

Thanks for your help!


semiyd


> Date: Mon, 12 Nov 2007 11:24:54 -0700
> From: bmidgley@gmail.com
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Does Bluez3.22 support SPP?
>
> semiyd
>
> on ubuntu the package is "python-dbus" and yes bluez supports spp. The
> older method uses /etc/bluetooth/rfcomm.conf but you can also use dbus
> to get the new method.
>
> --
> Brad
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems? Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now>> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE


--===============0898286921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0898286921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0898286921==--
