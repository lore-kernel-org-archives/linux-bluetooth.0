Return-Path: <cyrus@holtmann.org>
Message-ID: <217103.89543.qm@web52606.mail.re2.yahoo.com>
Date: Tue, 15 Dec 2009 12:52:45 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: obexd - retrieve remote BT address
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,  my application is:
1. remote device send it a file via opp.
2. my app will send back some file to the remote device base on the file name, file type and file content of the received file.
  obexd is doing fine, received the file and put it in the proper directory. The critical thing I need now is the bluetooth address to associate it with the received file.
  I tried look into the obex.c ... but could not easily figure out how to get the back the bluetooth address. 
  Any hint from our guru?

Ed


      __________________________________________________________________
The new Internet Explorer® 8 - Faster, safer, easier.  Optimized for Yahoo!  Get it Now for Free! at http://downloads.yahoo.com/ca/internetexplorer/
