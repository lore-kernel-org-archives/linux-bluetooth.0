Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 21 Sep 2011 21:20:53 +0200
From: "Michael Lochov" <mlochov@gmx.com>
Message-ID: <20110921192053.136390@gmx.com>
MIME-Version: 1.0
Subject: Frequency Hop Selection Help
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This question is more related to the Bluetooth specification that Bluez, specifically I'm trying to understand the frequency hopping selection for Inquiry scan mode. I have a working selection kernel that works perfectly for the basic 79 channel connected state and I now want to alter the inputs to get it working for the Inquriy state.

According to the specification (p94 of v4), BD_ADDR input to the selection kernel is replaced by the GIAC 0x9E8B33 and the DIC 0x00 for inquiry mode, so everything in my selection kernel that used an Address, i replaced with 0x009E8B33. 

The only other major change is the X input, defined as: Xi = { CLKN[16-12] + k_offset + ( CLKN[4-2,0] + CLKN[16-12] ) mod 16 } mod 32. Here I assumed the 4-2,0 bit positions of the native clock to mean I use bits 4,3,2,0. And i used 8 as the k_offset, is this correct?

The problem is I don't get the correct channel values out, but I know my selection kernel works perfectly for connected state so there is a problem specific with my inquiry mode inputs. Either im using the GIAC incorrectly and ignoring the ULAP or im understanding the X = {} forumula wrong.

To make matters more confusing, the sample data (p. 1235) is different across the 3 examples for inquiry mode? The only difference is the ULAP, which I understood was replaced with the GIAC here? So surely only the clock & k_offset should effect the frequency selection in inquiry mode.

Thanks very much.

Michael
