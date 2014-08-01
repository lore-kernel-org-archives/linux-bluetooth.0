Return-Path: <cyrus@holtmann.org>
From: Aravind Parvathala <Aravind.Parvathala@csr.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Re: HoG: Support multi output report
Date: Fri, 1 Aug 2014 12:06:18 +0000
Message-ID: <34DE67E73839C446B4269BCE8A1F303A01248EBDD5@CAMEUREXM01.EUROPE.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
Further to Murat's response I am interested in the solution you mentioned.

>>On Thurs, July 31, 2014 at 09:11 AM, Luiz Augusto von Dentz <luiz.dentz <at> gmail.com> wrote:
>>Hi Murat,
>
>Hi Luiz,
>
>>
>>On Wed, Jul 30, 2014 at 5:34 PM, Murat Kilivan <Murat.Kilivan <at> csr.com> wrote:
>>> Hi,
>>>
>>> I have a BLE HID device which has 2 output reports and it is discovered properly by BlueZ. However, when I
>try to send an output report it always >calls the first registered report id's handle. It doesn't matter
>what the first byte is in the message.
>>>
>>> How can I send to a different output report?
>>>
>>> I can supply any log/debug output if it is needed.
>>
>>I had the impression that you would have to have another instance to access the second output but perhaps we
>>should check the report id but then the question is how do you know what are the available report ids? We
>>never expose those to uHID so is this supposed to be hardcoded?

What did you mean by another instance? Is there a way to configure the blue-z stack to create separate instances (are they hidraw device instances or something else) for each of the HID output report?

Any suggestions on how to achieve that? Can the HID report map be configured such that there are two different collections, each with one output report so that the kernel enumerates them as two different device instances?



>
>The available report ids can be found in the report map. 
>
>Here is the bluetoothd log, It seems two output reports (id:5 and id:6) have been registered. 
>
>bluetoothd[2342]: profiles/input/hog.c:report_reference_cb() Report ID: 0x05 Report type: 0x03
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_unref() 0x836a848: ref=6
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_ref() 0x836a848: ref=7
>bluetoothd[2342]: profiles/input/hog.c:report_reference_cb() Report ID: 0x05 Report type: 0x02
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_unref() 0x836a848: ref=6
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_ref() 0x836a848: ref=7
>bluetoothd[2342]: profiles/input/hog.c:report_ccc_written_cb() Report characteristic
>descriptor written: notifications enabled
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_unref() 0x836a848: ref=6
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_ref() 0x836a848: ref=7
>bluetoothd[2342]: profiles/input/hog.c:report_reference_cb() Report ID: 0x05 Report type: 0x01
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_unref() 0x836a848: ref=6
>bluetoothd[2342]: attrib/gattrib.c:g_attrib_ref() 0x836a848: ref=7
>bluetoothd[2342]: profiles/input/hog.c:report_reference_cb() Report ID: 0x06 Report type: 0x02
>
>>
>>Futhermore the HoG code has been changed in android/hog.c and at some point it will be moved to src/shared
>>so it can be reused by input plugin.
>
>



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
