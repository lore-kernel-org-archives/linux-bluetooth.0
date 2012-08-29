Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: sonnyrao@google.com
In-Reply-To: <CAPz6YkXjRAPs1UMGXPqGMDFYjcs_8ggxinF7sYNyjhYfgCBAAQ@mail.gmail.com>
References: <CAPz6YkVEwWzosE5Tda+SvtmV1=0Q9g5uyW+RZsOVgOxT79c15Q@mail.gmail.com>
 <2583063.yEXEROAGYt@linux-lqwf.site> <CAPz6YkXjRAPs1UMGXPqGMDFYjcs_8ggxinF7sYNyjhYfgCBAAQ@mail.gmail.com>
From: Sonny Rao <sonnyrao@chromium.org>
Date: Tue, 28 Aug 2012 21:13:43 -0700
Message-ID: <CAPz6YkVxwv_7XA7P7kqPdfXC2Yr5DsK8nMW_q-c=68QH8B0R6g@mail.gmail.com>
Subject: Re: kernel crashes coming from btusb
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	vpalatin@chromium.org, keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 27, 2012 at 8:02 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
> On Mon, Aug 27, 2012 at 6:06 AM, Oliver Neukum <oliver@neukum.org> wrote:
>> On Monday 27 August 2012 03:30:55 Sonny Rao wrote:
>>> Hi, I've been investigating an issue where we were seeing random
>>> kernel crashes soon after resume and after using the great debugging
>>> facilities in SLUB I started getting output which pointed to "use
>>> after free" from the btusb driver.
>>
>> Which kernel version?
>>
>>         Regards
>>                 Oliver
>>
>
> Oops sorry, kernel 3.4

After some more investigation I am seeing the DMA unmap and it looks
like everything is okay as far as the driver tearing down the intr URB
correctly, sorry for the noise stating otherwise. This could be a
hardware issue if the host controller is still dmaing over that
transfer buffer.  I'll look into that some more, thanks.
