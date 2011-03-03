Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6FD0E9.1020602@csr.com>
Date: Thu, 03 Mar 2011 17:33:29 +0000
From: Marco Sinigaglia <marco.sinigaglia@csr.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: D-Bus for LE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am looking the D-Bus API for low energy and I cannot find a way to run 
a discover for LE devices and connect to them.
Are these API implemented? if not, are they going to be?


Looking the attribute-api it should be possible to do some stuff on the 
local device but, on my box, it looks like not working.
I am sure that the blutoothd is kicking off the attribute server 
(sdptool is showing the le profiles), nevertheless the test-attrib is 
showing nothing:

 >sudo ./test-attrib  -i hci0
[nothing]

Cheers
Marco


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
