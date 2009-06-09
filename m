Return-Path: <cyrus@holtmann.org>
Message-ID: <C8BAD89E00F6479FBCA47D5EB8A39A98@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: Problems building lexer.c in rfcomm
Date: Tue, 9 Jun 2009 09:30:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am working in audio/control.c, and cannot "make" bluez 4.40 (plus my 
changes, all in audio/control.c).

The make is failing when building rfcomm/lexer.c:

cc1: warnings being treated as errors
lexer.c: In function 'yy_get_next_buffer'
lexer.c:1095: error: comparison between signed and unsigned

Has anyone else seen this error?  How did you deal with it or work 
around it?

I am developing on an AMD64-based box running the Mandriva 2009 based on 
2.6.27.21.

David Stockwell 

