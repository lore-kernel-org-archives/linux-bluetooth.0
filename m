Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 18 Dec 2007 19:05:58 +0530
Message-Id: <1197984959.21252.31.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [HFP] New Methods/Signals.
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

Marcel/Johan, 

some new Methods/Signals are required for HFP in the audio service. Here
are the ones needed as of now. 

Method:
	void CallSetup(uint16 value)
	
		Used to send "callsetup" indicator value to the HF.

Signal:
	void TerminateCall()
		
		This signal is sent when an ongoing call is terminated.


An appropriate method name would be IndicateCall(), But thats already
used for Alerting(RING) the Headset/HFP. 

Is it possible to use Alert() instead of IndicateCall() to RING the
headset/HF and use IndicateCall to send "callsetup" indicator? 


The headset method implementations start with hs_* . Should the hf
methods prepend hf_ to them for distinguishing them from headset
methods ?   


-Alok 






-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
