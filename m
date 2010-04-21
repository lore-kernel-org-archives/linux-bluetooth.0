Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Apr 2010 21:34:33 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: eL2CAP git tree
Message-ID: <20100421003433.GA2275@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Since my code is still not merged in bluetooth's kernel tree and might
be some people interested in help with the eL2CAP development, I'm
posting my tree here. eL2CAP means the Enhanced Retransmission and
Streaming Modes, Segmentation and Reassembly, and Frame Check
Sequence(FCS).

My git tree is hosted at:

http://git.profusion.mobi/cgit.cgi/padovan/bluetooth-testing/

and you can clone it from here:

git://git.profusion.mobi/users/padovan/bluetooth-testing.git 

The code is on the branch 'ertm'.

If you wanna help with testing there is a patch that adds debug output
on the top of the branch 'test'.

Comments, suggestion, patches and bug reports are all welcome ;)

Regards,

-- 
Gustavo F. Padovan
http://padovan.org
