Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300708170701pa03fb82qeb75e8cc755c2e5b@mail.gmail.com>
References: <006d01c7d7fc$df2c2090$0102a8c0@dlh.st.com>
	<d89ddf300708060727r2f2165dawfec381fd3506ec44@mail.gmail.com>
	<1186856433.6698.37.camel@violet>
	<d89ddf300708170701pa03fb82qeb75e8cc755c2e5b@mail.gmail.com>
Date: Fri, 17 Aug 2007 16:08:07 +0200
Message-Id: <1187359687.6698.393.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] A2dp on ARM9- Quality not good
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Brad,

> > I think that is a job for our friends from Brazil. Ping them and see if
> > they can work something out.
> 
> I did send Walter an email to ask him about it.
> 
> They had talked about porting to the dsp, but the general purpose code
> should be tightened up first.

yes, the DSP implementation is actually unimportant right now. I would
not even know how to integrate that. We need to fix the main SBC library
inside bluez-utils first.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
