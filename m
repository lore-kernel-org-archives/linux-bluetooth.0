Return-Path: <cyrus@holtmann.org>
Message-ID: <524968.95124.qm@web52608.mail.re2.yahoo.com>
Date: Wed, 28 Apr 2010 13:14:42 -0700 (PDT)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: obexd pull-business-card
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I could not get on the same thread with Daniel and Luiz.
I am trying to get pull-business-card working.  The target is a Blackberry (with pin code ...).
When I ran it, with paring sucess...
The script will fail, ...DBusException:  org.Openobex.Error.Failed:
Dbus-monitor will 
error sender.. error_name=Openobex.Error.Failed reply_serial=4
  string ""

Then I remember on the Blackberry normally the obex service is off so I
 get into it's media menu and select "receive using bluetooth.."
The script now pass. 
Dbus-monitor 
   method call  ... serial=4
         ....
      string "d.vcf"
   method return  ... reply_serial=4

but the file is no where to find.
I tried with "default.vcf" as file name ... still no file.
My stupid question is do we need to use a predefined name "d.vcf  or default.vcf or ..?"
 Or could it be the phone don't have a default vcard?
  Or the ull-business-card is not functioning correctly?
  Any hint?

Regards, 
Ed


