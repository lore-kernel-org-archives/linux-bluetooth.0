Return-Path: <cyrus@holtmann.org>
From: "Cukier, Johnas" <Johnas_Cukier@bose.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Spotted minor bug in btgatt-client.c
Date: Tue, 21 Jul 2015 20:25:06 +0000
Message-ID: <SN1PR0801MB1582A043B013B75D8A3D3149E3840@SN1PR0801MB1582.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


I have the BlueZ v. 5.32 release distribution. I was trying to use the BTLE GATT client in the tools subdirectory. All worked fine until I tried to send bytes to the GATT server. Using the "write-value" command, I'm able to send data to a particular handle. However, the data bytes are restricted to two-digit decimals. So, if I try to send 100 (ASCII 'd'), I get an error message. I spotted the problem in lines 728 - 742 (listed below):

728: for (i = 1; i < argc; i++) {
729: if (strlen(argv[i]) != 2) {
730: printf("Invalid value byte: %s\n",
731: argv[i]);
732: goto done;
733: }
734:
735: value[i-1] = strtol(argv[i], &endptr, 0);
736: if (endptr == argv[i] || *endptr != '\0'
737: || errno == ERANGE) {
738: printf("Invalid value byte: %s\n",
739: argv[i]);
740: goto done;
741: }
742: }

In line 729, the data byte is restricted to a string length of two. In line 735, the byte is converted to a decimal number. Since, the string is restricted to length 2, the byte cannot be prefixed by "0x". So, the strtol() function always converts the byte to decimal. My quick solution was to modify line 735 to read as follows:

735: value[i-1] = strtol(argv[i], &endptr, 16);

This makes the assumption that all data bytes are in hexadecimal (without the "0x" prefix). This may be confusing to the user since the handle needs the "0x" prefix for it to be interpreted as a hex number. As I said, this is a quick fix that I implemented in my version.

I've tested this solution and it works now.

  
 Johnas Cukier
 Bose Corporation
 (508)766-9097
 Johnas_Cukier@bose.com
    