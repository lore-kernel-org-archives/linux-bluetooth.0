Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1411061100280.886-100000@iolanthe.rowland.org>
References: <CAG0bkv+DL0bVs9irE7eUB3rC-J16Ue=b9+_TqeuTHJYMJDkC0g@mail.gmail.com>
	<Pine.LNX.4.44L0.1411061100280.886-100000@iolanthe.rowland.org>
Date: Mon, 10 Nov 2014 14:59:17 +0530
Message-ID: <CAG0bkvLdCRoC=MTFfusF63WPKXB55+cEZRb3MnQ339RgK3-KKg@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 6, 2014 at 10:14 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 6 Nov 2014, Naveen Kumar Parna wrote:
>
>> > Any idea why you see the CSPLITs now but didn't see them before?
>>
>> It looks like , I failed to locate the exact portion of the analyzer
>> log that corresponds to one of those -32 events in the usbmon log.
>
> Well, I still don't understand that, but never mind...
>
>> USB Analyzer records several megabytes of data very quickly, so it’s
>> very hard to find the portion of the analyzer log that corresponds to
>> one of those -32 events in the usbmon log. To avoid this difficulty I
>> applied the attached patch
>> (0002-btusb-clear-halt-if-intr-in-stalls.patch – got it from Oliver
>> Neukum) to btusb driver and reloaded this driver.
>>
>> The applied patch calls usb_clear_halt() on receiving the stall
>> response, so now I can easily search for ClearFeature(ENDPOINT_HALT)
>> request in the analyzer log. It can be found at "2.304 252 217" &
>> "2.316 264 600" time instance in the attached log.
>>
>> Re ran the Analyzer again and attached it’s exported text
>> log([2014-11-06 session 125138] Trace0000_only_ep0_ep1.txt). Here
>> filtered out the BulkIN transactions.
>>
>> usbmon log:
>> ffff8800b7670a80 506095728 C Ii:1:108:1 -32:1 0
>> ffff8800affdccc0 506107757 C Ii:1:108:1 -32:1 0
>
>> Here is the portion of the log that corresponds to “ffff8800b7670a80
>> 506095728 C Ii:1:108:1 -32:1 0”:
>>
>> Start of Frame (6) HS 553.2 -> 553.7 2.302 964 717
>> SSPLIT IN transaction 105 1 HS No data 2.303 590 367
>> SSPLIT IN transaction 106 1 HS No data 2.303 591 283
>> SSPLIT IN transaction 107 1 HS No data 2.303 600 283
>> SSPLIT IN transaction 108 1 HS No data 2.303 601 350
>> Start of Frame (2) HS 554.0 -> 554.1 2.303 714 817
>> CSPLIT IN transaction 105 1 NAK HS No data 2.303 840 400
>> CSPLIT IN transaction 106 1 NAK HS No data 2.303 842 033
>> CSPLIT IN transaction 107 1 NAK HS No data 2.303 855 317
>> Start of Frame (3) HS 554.2 -> 554.4 2.303 964 850
>
> Obviously, there aren't any CSPLITs for device 108 ep 1.
>
>> Here is the portion of the log that corresponds to “ffff8800affdccc0
>> 506107757 C Ii:1:108:1 -32:1 0":
>>
>> Start of Frame (6) HS 565.2 -> 565.7 2.314 966 383
>> SSPLIT IN transaction 105 1 HS No data 2.315 592 033
>> SSPLIT IN transaction 106 1 HS No data 2.315 592 967
>> SSPLIT IN transaction 107 1 HS No data 2.315 612 800
>> SSPLIT IN transaction 108 1 HS No data 2.315 613 850
>> Start of Frame (2) HS 566.0 -> 566.1 2.315 716 483
>> CSPLIT IN transaction 105 1 NAK HS No data 2.315 842 067
>> CSPLIT IN transaction 106 1 NAK HS No data 2.315 843 683
>> CSPLIT IN transaction 107 1 NAK HS No data 2.315 928 750
>> Start of Frame (3) HS 566.2 -> 566.4 2.315 966 517
>
>> In both the cases, CSPLIT of Dev-108 is missing in this portion of the log.
>>
>> So, Does this test log gives some conclusion?
>
> It indicates that the EHCI host controller hardware isn't working
> right.  Every now and then it skips sending CSPLIT packets when it
> should send them.
>
> I suppose it's possible that the host controller is okay and the
> problem is a bad memory chip.  That could also cause this sort of
> error.  Regardless, it has to be a hardware problem.

Is there any test I can run to prove that memory chip is bad?


>
> Now, this doesn't explain why you get the -32 status code.  Maybe the
> patch below will provide more information.  Try running your test with
> this patch installed and see what shows up in the dmesg log.
>
> Alan Stern
>
>
>
> Index: usb-3.18/drivers/usb/host/ehci-q.c
> ===================================================================
> --- usb-3.18.orig/drivers/usb/host/ehci-q.c
> +++ usb-3.18/drivers/usb/host/ehci-q.c
> @@ -346,6 +346,12 @@ qh_completions (struct ehci_hcd *ehci, s
>                 /* always clean up qtds the hc de-activated */
>   retry_xacterr:
>                 if ((token & QTD_STS_ACTIVE) == 0) {
> +                       u32 info2 = hc32_to_cpu(ehci, hw->hw_info2);
> +
> +                       if ((info2 & QH_SMASK) && (token & 0x7e))
> +                               ehci_info(ehci, "split intr info2 %x token %x overlay token %x\n",
> +                                               info2, token, hc32_to_cpu(ehci,
> +                                                       hw->hw_token));
>
>                         /* Report Data Buffer Error: non-fatal but useful */
>                         if (token & QTD_STS_DBE)
>

Here is the dmesg log:

[  713.125709] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
80108d46 overlay token 80108d46
[  713.125796] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
80108d46 overlay token 80108d46
[  713.125853] hci4 urb ffff8800b89a7c00 status -32 count 0
[  713.125857] hci3 urb ffff8800b7399c00 status -32 count 0
[  713.126801] hci4
[  713.127003] hci3
[ 3046.032153] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 3046.032227] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 3046.032272] hci3 urb ffff8800b30f5a80 status -32 count 0
[ 3046.032278] hci4 urb ffff8800b30f53c0 status -32 count 0
[ 3046.033326] hci4
[ 3046.033344] hci3
[ 3586.175590] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 3586.175698] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 3586.175759] hci4 urb ffff8800b8a64a80 status -32 count 0
[ 3586.175766] hci3 urb ffff8800b8a64cc0 status -32 count 0
[ 3586.176625] hci4
[ 3586.177000] hci3
[ 4310.473875] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 4310.473972] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 4310.474019] hci3 urb ffff8800b3099c00 status -32 count 0
[ 4310.474023] hci4 urb ffff8800b3099480 status -32 count 0
[ 4310.474912] hci3
[ 4310.475027] hci4
[ 4313.710199] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 4313.710325] hci4 urb ffff8800b8012a80 status -32 count 0
[ 4313.711207] hci4
[ 4314.722302] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 4314.722359] hci4 urb ffff8800b8012a80 status -32 count 0
[ 4314.723472] hci4
[ 5210.940319] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5210.940423] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5210.940471] hci4 urb ffff8800b8012a80 status -32 count 0
[ 5210.940475] hci3 urb ffff8800b8012180 status -32 count 0
[ 5210.941309] hci4
[ 5210.941703] hci3
[ 5211.464329] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5211.464437] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5211.464490] hci3 urb ffff8800b8bb9000 status -32 count 0
[ 5211.464493] hci4 urb ffff8800b8bb90c0 status -32 count 0
[ 5211.465367] hci4
[ 5211.465383] hci3
[ 5211.508336] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5211.508426] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5211.508469] hci4 urb ffff8800b8bb9000 status -32 count 0
[ 5211.508472] hci3 urb ffff8800b8bb90c0 status -32 count 0
[ 5211.509375] hci3
[ 5211.509390] hci4
[ 5212.144419] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5212.144500] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5212.144539] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
80108d46 overlay token 80108d46
[ 5212.144598] hci3 urb ffff8800b8bb9000 status -32 count 0
[ 5212.144603] hci4 urb ffff8800b8bb90c0 status -32 count 0
[ 5212.144605] hci2 urb ffff8800b7399600 status -32 count 0
[ 5212.145406] hci3
[ 5212.145685] hci4
[ 5212.145697] hci2
[ 5212.284485] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5212.284603] hci2 urb ffff8800b8bb9180 status -32 count 0
[ 5212.285452] hci2
[ 5213.084540] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5213.084660] hci2 urb ffff8800b8bb9180 status -32 count 0
[ 5213.085778] hci2
[ 5213.996615] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5213.996763] hci2 urb ffff8800b8bb9180 status -32 count 0
[ 5214.000391] hci2
[ 5216.156816] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5216.156939] hci2 urb ffff8800b8bb9180 status -32 count 0
[ 5216.157807] hci2
[ 5741.146808] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5741.146906] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5741.146946] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 5741.146994] hci2 urb ffff8800b8bb9180 status -32 count 0
[ 5741.146998] hci4 urb ffff8800b8bb9000 status -32 count 0
[ 5741.147001] hci3 urb ffff8800b8bb90c0 status -32 count 0
[ 5741.147807] hci2
[ 5741.148068] hci3
[ 5741.148204] hci4
[ 8327.577511] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 8327.577600] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 8327.577639] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 8327.577690] hci3 urb ffff8800b8bb9d80 status -32 count 0
[ 8327.577695] hci4 urb ffff8800b8bb9180 status -32 count 0
[ 8327.577697] hci2 urb ffff8800b8bb90c0 status -32 count 0
[ 8327.578683] hci4
[ 8327.578698] hci2
[ 8327.581162] hci3
[ 9347.950892] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 9347.951007] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 9347.951046] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 9347.951108] hci2 urb ffff8801399bf600 status -32 count 0
[ 9347.951113] hci4 urb ffff8801399bff00 status -32 count 0
[ 9347.951115] hci3 urb ffff8801399bf6c0 status -32 count 0
[ 9347.952070] hci2
[ 9347.952307] hci4
[ 9347.952422] hci3
[10016.619096] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.619188] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.619227] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.619288] hci3 urb ffff8800b4097000 status -32 count 0
[10016.619293] hci4 urb ffff8800b4097240 status -32 count 0
[10016.619295] hci2 urb ffff8800b4097480 status -32 count 0
[10016.620257] hci4
[10016.620273] hci2
[10016.625393] hci3
[10016.663094] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.663178] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.663228] hci3 urb ffff8800371c1900 status -32 count 0
[10016.663233] hci2 urb ffff8800371c1cc0 status -32 count 0
[10016.664152] hci3
[10016.664162] hci2
[10016.683124] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.683200] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.683239] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10016.683289] hci2 urb ffff8800371c1900 status -32 count 0
[10016.683293] hci3 urb ffff8800371c1cc0 status -32 count 0
[10016.683295] hci4 urb ffff8800371c1000 status -32 count 0
[10016.684132] hci4
[10016.684139] hci3
[10016.684144] hci2
[10366.025162] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10366.025240] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10366.025280] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[10366.025332] hci4 urb ffff8800371c1900 status -32 count 0
[10366.025336] hci3 urb ffff8800371c1cc0 status -32 count 0
[10366.025339] hci2 urb ffff8800371c1000 status -32 count 0
[10366.026485] hci3
[10366.026502] hci4
[10366.026565] hci2
[11095.765903] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11095.765981] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11095.766021] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11095.766085] hci2 urb ffff8800372ad9c0 status -32 count 0
[11095.766090] hci3 urb ffff8800372ad6c0 status -32 count 0
[11095.766092] hci4 urb ffff8800372ad240 status -32 count 0
[11095.767016] hci2
[11095.767032] hci3
[11095.767043] hci4
[11527.042340] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11527.042425] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11527.042464] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11527.042516] hci4 urb ffff8800aed34780 status -32 count 0
[11527.042520] hci3 urb ffff8800aed34c00 status -32 count 0
[11527.042522] hci2 urb ffff8800aed343c0 status -32 count 0
[11527.043377] hci4
[11527.043479] hci3
[11527.043983] hci2
[11716.767697] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11716.767769] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11716.767816] hci2 urb ffff8800b88be840 status -32 count 0
[11716.767820] hci3 urb ffff8800b88bed80 status -32 count 0
[11716.768712] hci3
[11716.768721] hci2
[11816.865884] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11816.865964] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11816.866003] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11816.866058] hci3 urb ffff8800b88be840 status -32 count 0
[11816.866063] hci2 urb ffff8800b88bed80 status -32 count 0
[11816.866065] hci4 urb ffff8800b88bea80 status -32 count 0
[11816.867026] hci2
[11816.867112] hci3
[11816.869653] hci4
[11816.877845] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11816.877950] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11816.877994] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[11816.878058] hci4 urb ffff8800b88be840 status -32 count 0
[11816.878062] hci2 urb ffff8800b88bed80 status -32 count 0
[11816.878064] hci3 urb ffff8800b88bea80 status -32 count 0
[11816.878885] hci2
[11816.878901] hci4
[11816.878910] hci3


Thanks,
Naveen
