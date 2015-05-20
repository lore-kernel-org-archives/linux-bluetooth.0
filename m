Return-Path: <cyrus@holtmann.org>
Message-id: <555C7F93.9080901@samsung.com>
Date: Wed, 20 May 2015 21:35:31 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, chanyeol.park@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Kim@samsung.com,
 Ben Young Tae <ytkim@qca.qualcomm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Support for QCA61x4 on Samsung
References: <1432017670-6024-1-git-send-email-chanyeol.park@samsung.com>
 <D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org>
In-reply-to: <D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org>
Content-type: multipart/alternative;
 boundary=------------040104060201050502040102
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040104060201050502040102
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,
On 05/20/2015 03:21 AM, Marcel Holtmann wrote:
> Hi Chan-yeol,
>
>> The previous commit(3267c88) regressed QCA61x4 BT on Samsung because
>> its device info is missed in qca_devices_table[], so btusb_open()
>> return error unexpectedly.
> how does this regress. We never had QCA module support in the first place. The patch looks good, I was just wondering what the regression will be here?
>
My environment was virtual box on windows.
I guess windows download QC firmware successfully, so without firmware 
handling in the linux I could use bluetooth adapter.

Until now , I fail to find the exact firmware , "qca/rampatch_usb_*.bin" 
for QCA61x4.
I just saw the mail that Kyle McMartin reject firmware patches made by 
Ben Young Tae Kim.
Could you tell where I can get it?

Actually my wifi QCA61x4 does not work well..

Thanks
Chanyeol


--------------040104060201050502040102
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Marcel,<br>
      On 05/20/2015 03:21 AM, Marcel Holtmann wrote:<br>
    </div>
    <blockquote
      cite="mid:D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org"
      type="cite">
      <pre wrap="">Hi Chan-yeol,

</pre>
      <blockquote type="cite">
        <pre wrap="">The previous commit(3267c88) regressed QCA61x4 BT on Samsung because
its device info is missed in qca_devices_table[], so btusb_open()
return error unexpectedly.
</pre>
      </blockquote>
      <pre wrap="">
how does this regress. We never had QCA module support in the first place. The patch looks good, I was just wondering what the regression will be here?

</pre>
    </blockquote>
    My environment was virtual box on windows.<br>
    I guess windows download QC firmware successfully, so without
    firmware handling in the linux I could use bluetooth adapter.<br>
    <br>
    Until now , I fail to find the exact firmware ,
    "qca/rampatch_usb_*.bin" for QCA61x4.<br>
    I just saw the mail that
    <meta http-equiv="content-type" content="text/html;
      charset=windows-1252">
    Kyle McMartin reject firmware patches made by
    <meta http-equiv="content-type" content="text/html;
      charset=windows-1252">
    Ben Young Tae Kim.<br>
    Could you tell where I can get it?<br>
    <br>
    Actually my wifi QCA61x4 does not work well.. <br>
    <br>
    Thanks<br>
    Chanyeol<br>
    <br>
  </body>
</html>

--------------040104060201050502040102--
