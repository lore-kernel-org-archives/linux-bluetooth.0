Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300708060727r2f2165dawfec381fd3506ec44@mail.gmail.com>
Date: Mon, 6 Aug 2007 08:27:33 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <006d01c7d7fc$df2c2090$0102a8c0@dlh.st.com>
MIME-Version: 1.0
References: <006d01c7d7fc$df2c2090$0102a8c0@dlh.st.com>
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

Sumeet,

first, try different encoder settings. some settings use more
bandwidth but less cpu.

also see the todo items from sbc.c:

  use a log2 table for byte integer scale factors calculation (sum
log2 results for high and low bytes)
  fill bitpool by 16 bits instead of one at a time in bits
allocation/bitpool generation
  port to the dsp
  don't consume more bytes than passed into the encoder

some of these were suggested to me by the guy writing an encoder for
palm 700p. I didn't dig into the algorithm to see how they would work.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
