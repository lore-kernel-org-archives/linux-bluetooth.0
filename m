Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <53BC229C-4E4E-4014-87EC-F093B1276DF0@cadvium.net>
References: <53BC229C-4E4E-4014-87EC-F093B1276DF0@cadvium.net>
Date: Fri, 24 Aug 2007 14:23:16 +0200
Message-Id: <1187958196.15402.167.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] handsfree profile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Robert,

> i am developing an implementation of the handsfree profile (The  
> Handsfree side rather than the Audio Gateway).  So far I have  
> traction in every area except for SCO connections.
> 
> What exactly does bluez-alsa project do?  I am a little unclear about  
> what is an alsa driver, and what part is a daemon.  How would I get  
> data from the cell phone to the speakers, and data from the  
> microphone back to cell phone?  From everything I have read it  
> appears to be the Audio Gateway portion of the handsfree profile, but  
> after playing around with it, I am not sue.

the main focus will be Handsfree audio gateway. For the Handsfree device
part I don't know when we will support it. We might do it at some point,
but it certainly has not high priority.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
