Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY122-F29B0D0BF70AB817B5341FAFFD50@phx.gbl>
From: "jaspreet singh" <manny.india@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 22 Aug 2007 11:37:54 +0530
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Resource
	temporarilyunavailable
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

try:  #rfcomm bind <address>
if it says already binded..then release and bind again..
check rfcomm for the channel...
#rfcomm
it should say <addr.> <channelno> clean
then it will be ok...

if problem persists than forgive me..ask any expert..

_________________________________________________________________
Wedding bells are ringing. When's your time to walk the aisle? 
http://ad.in.doubleclick.net/clk;112111293;17571293;v?http://www.simplymarry.com/timesmatri/faces/jsp/UserTrackLandingPage.jsp?origin=hotmail_taglines_ros_june07


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
