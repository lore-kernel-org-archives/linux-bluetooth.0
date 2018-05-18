Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?Q?Gr=c3=a9goire_Gentil?= <gregoire@gentil.com>
Subject: Where is the documentation of l2cap_options?
Reply-To: gregoire@gentil.com
To: linux-bluetooth@vger.kernel.org
References: <f4fea7cd-a68c-abc4-3e5e-c4ff80df118c@gentil.com>
 <20161230072113.GA20773@x1c.P-661HNU-F1>
Message-ID: <4afa32dd-c21d-d1a8-b077-470bde05e5cc@gentil.com>
Date: Fri, 18 May 2018 10:40:01 -0700
MIME-Version: 1.0
In-Reply-To: <20161230072113.GA20773@x1c.P-661HNU-F1>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,


I have a couple of questions regarding l2cap_options.

I have posted the main question on Stackoverflow:
https://stackoverflow.com/questions/50380020/where-is-the-documentation-of-l2cap-options


I would like to play with the options of l2cap. But there is no 
documentation even in the kernel header. Where can I find a description 
of the different fields?

On my system, I see:
omtu:0 imtu:672 flush_to:65535 mode:0 fcs:1 max_tx:3 txwin_size:63

I don't understand why omtu is different from imtu. What are the other 
options?


Also, on this page 
https://people.csail.mit.edu/albert/bluez-intro/x95.html#l2cap-and-udp, 
it says that there are three policies possible: never retransmit, 
default, drop and move. How do I select the policy?

I was guessing that the "default" is to have flush timeout of 0 and the 
"drop and move" after x ms is just to put a specific timeout (knowing 
that 1279ms = 0x7ff * 625us). Am I right? But then how do you select 
"never retransmit"?


Grégoire



