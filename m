Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket Rev H?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051009021816.GA25928@suave.net>
References: <20051007150204.GA18594@suave.net>
	 <1128774980.5212.6.camel@blade>  <20051009021816.GA25928@suave.net>
Content-Type: text/plain
Message-Id: <1128849028.15821.2.camel@blade>
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
Date: Sun, 09 Oct 2005 11:10:28 +0200

Hi Anthony,

>   Ugh.. still having problems... looking all over for serial_cs modules
> for 2.4.18-rmk7-pxa3-embedix... I found some precompiled ones that I
> loaded but dmesg says "ds: unable to create instance of 'serial_cs'!"
> 
>   Also, when dmesg says
> ttyS03 at port 0xc48603f8 (irq = 35) is a 16C950/954
>  
>   I assume that means /dev/ttyS3... I tried
> hciattach ttyS3 csr
> hciattach ttyS3 bcsp
> and
> hciattach ttyS3 any
> 
>   None of those seem to work.. any gives back hciconfig, but the
> address is all zeros... 

you need to use bcsp and specify the correct baudrate. Check the mailing
list archive for details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
