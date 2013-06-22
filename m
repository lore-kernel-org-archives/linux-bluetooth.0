Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: regression in sdp lib
Date: Sat, 22 Jun 2013 15:52:13 +0200
Message-ID: <2305165.rjtI9Kq64V@athlon>
In-Reply-To: <CAJdJm_P90hv0PHwpk+VNSx=OivsLiA7bBSvS4E=4=6mT_BR81A@mail.gmail.com>
References: <1560638.biMD7yTzvv@athlon> <CAJdJm_P90hv0PHwpk+VNSx=OivsLiA7bBSvS4E=4=6mT_BR81A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 21 June 2013 18:38:34 Anderson Lizardo wrote:
> Hi Szymon,

Hi Anderson,

> 
> On Fri, Jun 21, 2013 at 4:09 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> > Hi,
> > 
> > commit 'lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP'
> > 1796f00e846561af broke sdp with Nokia BH217 headset.
> 
> Note that the commit only exposed the issue that the handling of these
> PDUs does not expect continuation PDUs. The reason the previous code
> worked was purely by luck, because the sdp_process() function
> allocates a large buffer and memset()s it to zero, so "pcstate" most
> likely will be zero (indicating the last continuation packet).
>
> > As discussed on IRC, sending bluetoothd and monitor logs.
> > 
> > It looks like if response is fragmented size should be verified after all
> > fragments are received, not for each fragment in separate..
> > 
> > I'm not sure how this should be fixed correctly. Suggestions are welcome.
> 
> Can you send the raw dump as well? hcidump shows SDP information that
> is not necessarily present on the PDU (but is collected/calculated
> from previous PDUs).

hcidump raw dump it is.


< 01 05 04 0D 7F 61 8C DE 1E 00 18 CC 02 00 00 00 01 
> 04 0F 04 00 01 05 04 
> 04 03 0B 00 0C 00 7F 61 8C DE 1E 00 01 00 
< 01 1B 04 02 0C 00 
> 04 0F 04 00 01 1B 04 
> 04 0B 0B 00 0C 00 BC FE 8F FE 1B FE 79 87 
< 01 1C 04 03 0C 00 01 
> 04 0F 04 00 01 1C 04 
> 04 23 0D 00 0C 00 01 01 01 00 00 00 00 00 00 00 
< 01 19 04 0A 7F 61 8C DE 1E 00 02 00 00 00 
< 02 0C 00 0A 00 06 00 01 00 0A 01 02 00 02 00 
> 04 0F 04 00 01 19 04 
> 02 0C 20 10 00 0C 00 01 00 0B 01 08 00 02 00 00 00 00 02 00 
  00 
< 02 0C 00 0C 00 08 00 01 00 02 02 04 00 01 00 40 00 
> 02 0C 20 10 00 0C 00 01 00 03 02 08 00 42 00 40 00 00 00 00 
  00 
< 02 0C 00 0C 00 08 00 01 00 04 03 04 00 42 00 00 00 
> 02 0C 20 10 00 0C 00 01 00 04 02 08 00 40 00 00 00 01 02 40 
  00 
< 02 0C 00 12 00 0E 00 01 00 05 02 0A 00 42 00 00 00 00 00 01 
  02 40 00 
> 02 0C 20 0E 00 0A 00 01 00 05 03 06 00 40 00 00 00 00 00 
< 02 0C 00 18 00 14 00 42 00 06 00 00 00 0F 35 03 19 01 00 FF 
  FF 35 05 0A 00 00 FF FF 00 
> 02 0C 20 43 00 3F 00 40 00 07 00 00 00 3A 00 35 35 A0 36 00 
  4A 09 00 00 0A 00 01 00 00 09 00 01 35 06 19 11 08 19 12 03 
  09 00 04 35 0C 35 03 19 01 00 35 05 19 00 03 08 01 09 00 05 
  35 03 19 10 02 09 00 09 35 02 00 35 
< 02 0C 00 1A 00 16 00 42 00 06 00 01 00 11 35 03 19 01 00 FF 
  FF 35 05 0A 00 00 FF FF 02 00 35 
> 02 0C 20 44 00 40 00 40 00 07 00 01 00 3B 00 36 08 35 06 19 
  11 08 09 01 00 09 01 00 25 0C 48 53 50 20 73 65 72 76 69 63 
  65 00 36 00 50 09 00 00 0A 00 01 00 01 09 00 01 35 06 19 11 
  1E 19 12 03 09 00 04 35 0C 35 02 00 6B 
< 02 0C 00 1A 00 16 00 42 00 06 00 02 00 11 35 03 19 01 00 FF 
  FF 35 05 0A 00 00 FF FF 02 00 6B 
> 04 07 FF 00 7F 61 8C DE 1E 00 4E 6F 6B 69 61 20 42 48 2D 32 
  31 37 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 04 13 05 01 0C 00 02 00 
> 04 13 05 01 0C 00 02 00 
> 04 13 05 01 0C 00 02 00 
> 02 0C 20 44 00 40 00 40 00 07 00 02 00 3B 00 36 03 19 01 00 
  35 05 19 00 03 08 02 09 00 05 35 03 19 10 02 09 00 09 35 08 
  35 06 19 11 1E 09 01 05 09 01 00 25 0C 48 46 50 20 73 65 72 
  76 69 63 65 00 09 03 11 09 00 02 00 A1 
< 02 0C 00 1A 00 16 00 42 00 06 00 03 00 11 35 03 19 01 00 FF 
  FF 35 05 0A 00 00 FF FF 02 00 A1 
> 04 13 05 01 0C 00 02 00 
> 02 0C 20 0D 00 09 00 40 00 07 00 03 00 04 00 01 1D 00 
< 02 0C 00 0C 00 08 00 01 00 06 04 04 00 42 00 40 00 
> 02 0C 20 0C 00 08 00 01 00 07 04 04 00 42 00 40 00 
> 04 13 05 01 0C 00 01 00 
> 04 05 04 00 0C 00 13 

-- 
Szymon K. Janc
szymon.janc@gmail.com
