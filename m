Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: "Cukier\, Johnas" <Johnas_Cukier@bose.com>,
	"linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Spotted minor bug in btgatt-client.c
In-Reply-To: <SN1PR0801MB1582A043B013B75D8A3D3149E3840@SN1PR0801MB1582.namprd08.prod.outlook.com>
References: <SN1PR0801MB1582A043B013B75D8A3D3149E3840@SN1PR0801MB1582.namprd08.prod.outlook.com>
Date: Fri, 24 Jul 2015 11:47:23 -0300
Message-ID: <871tfx629w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johnas,

"Cukier, Johnas" <Johnas_Cukier@bose.com> writes:

> I have the BlueZ v. 5.32 release distribution. I was trying to use the BTLE GATT client in the tools subdirectory. All worked fine until I tried to send bytes to the GATT server. Using the "write-value" command, I'm able to send data to a particular handle. However, the data bytes are restricted to two-digit decimals. So, if I try to send 100 (ASCII 'd'), I get an error message. I spotted the problem in lines 728 - 742 (listed below):
>
> 728: for (i = 1; i < argc; i++) {
> 729: if (strlen(argv[i]) != 2) {
> 730: printf("Invalid value byte: %s\n",
> 731: argv[i]);
> 732: goto done;
> 733: }
> 734:
> 735: value[i-1] = strtol(argv[i], &endptr, 0);
> 736: if (endptr == argv[i] || *endptr != '\0'
> 737: || errno == ERANGE) {
> 738: printf("Invalid value byte: %s\n",
> 739: argv[i]);
> 740: goto done;
> 741: }
> 742: }
>
> In line 729, the data byte is restricted to a string length of two. In line 735, the byte is converted to a decimal number. Since, the string is restricted to length 2, the byte cannot be prefixed by "0x". So, the strtol() function always converts the byte to decimal. My quick solution was to modify line 735 to read as follows:
>
> 735: value[i-1] = strtol(argv[i], &endptr, 16);
>
> This makes the assumption that all data bytes are in hexadecimal (without the "0x" prefix). This may be confusing to the user since the handle needs the "0x" prefix for it to be interpreted as a hex number. As I said, this is a quick fix that I implemented in my version.
>

Thanks for spotting this bug.

Looking at how the "read-value" displays the value (hexadecimal without
the 0x prefix), your quick solution seems at least consistent.

Could you send a patch for this?


Cheers,
--
Vinicius
