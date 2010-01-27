Return-Path: <cyrus@holtmann.org>
Message-ID: <615585.7801.qm@web52606.mail.re2.yahoo.com>
Date: Wed, 27 Jan 2010 12:27:53 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: hcitool cc ....    connected and drop
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 
I am trying to use hcitool to create a connection. The connection seem to be connected and dropped right the way.
Looking at the hcidump, look like the connect command is ok, but then there is a "read remote supported feature", "read remote name" then a "disconnect command".  
I tried to search "hci_read_remote_features" or usage of "OCF_READ_REMOTE_FEATURES" and put in debug print on all functions but could not figure out where the "read remote supported feature" was called from the "hcitool cc" command.
Anyone please point me to the trivial stuff.

Regards, 
Ed   



      __________________________________________________________________
Make your browsing faster, safer, and easier with the new Internet Explorer® 8. Optimized for Yahoo! Get it Now for Free! at http://downloads.yahoo.com/ca/internetexplorer/
