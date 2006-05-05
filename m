Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils vs patches
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <445AEC24.1010908@rootcore.co.za>
References: <4459F354.3020500@ubuntu.com>
	 <1146786624.2885.151.camel@hades.cambridge.redhat.com>
	 <445AEC24.1010908@rootcore.co.za>
Content-Type: text/plain
Message-Id: <1146863605.2503.1.camel@shinybook.infradead.org>
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
Date: Fri, 05 May 2006 22:13:25 +0100

On Fri, 2006-05-05 at 08:09 +0200, Charles Majola wrote:
> We can have a GUI or something to manage the device, so that by default 
> we leave the device in HID mode and the user can manually change it to 
> HCI and start a HID daemon. 

Yes, that might work. You have to click the button in the GUI and then
stick both your bluetooth keyboard and mouse into 'discoverable' mode so
that they get picked up. It's a complete PITA though, and there _has_ to
be a better way. MacOS manages it better than this.

-- 
dwmw2



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
