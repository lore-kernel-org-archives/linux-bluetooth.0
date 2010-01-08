Return-Path: <cyrus@holtmann.org>
Message-ID: <91473.91180.qm@web52605.mail.re2.yahoo.com>
Date: Fri, 8 Jan 2010 08:51:05 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: bluetooth-sendto dbus-timeout
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 
Hope one of you expert could help me on this.
I am trying to use bluetooth-sendto (bluz-gnome) to push files to remote and record detail of the result (e.g. cannot connect to SDP, cannot locate the opp .....). I was able to go into the obex-client to get more detail when the transfer fail.  But when the remote (user) do not response to the connection request, I got a DBUS_GERROR_REMOTE_EXCEPTION (Did not receive a reply...). 
   I am guessing the method timeout, but it was too fast (prefer to give the remote device user more time). 
  Is there a way to increase the timeout value to a much much larger number?
  Is there a time out on the obexd side on the SDP connect and rfcomm connect in case the user do not response to the connection request. 

Ed



      __________________________________________________________________
Looking for the perfect gift? Give the gift of Flickr! 

http://www.flickr.com/gift/
