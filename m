Return-Path: <cyrus@holtmann.org>
Message-ID: <15a4d3c6ac84009c192c73e3e2e88066.squirrel@mungewell.org>
In-Reply-To: <20150617124842.GA17715@t440s.P-661HNU-F1>
References: <06F67222-BAF1-455D-A4B8-4560FE84EE69@holtmann.org>
    <1433786660-2169-1-git-send-email-simon@mungewell.org>
    <20150617124842.GA17715@t440s.P-661HNU-F1>
Date: Wed, 17 Jun 2015 11:16:21 -0400
Subject: Re: [PATCH] bccmd - add ability to read ADC
From: simon@mungewell.org
To: linux-bluetooth@vger.kernel.org,
	"Marcel Holtmann" <marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> And the patch doesn't actually compile:
>
> tools/bccmd.c:1068:2: error: implicit declaration of function ‘usleep’
> [-Werror=implicit-function-declaration]
>   usleep(50000);

Huh, builds on Xubuntu 14.10...
--
simon@LinuxBuild:~/bluez-git$ make
make --no-print-directory all-am
  CC       tools/bccmd.o
  CCLD     tools/bccmd
simon@LinuxBuild:~/bluez-git$ grep  ADC tools/bccmd.c
	// Request an ADC read from a particular mux'ed input
	err = transport_write(transport, CSR_VARID_ADC, array, 2);
	err = transport_read(transport, CSR_VARID_ADC_RES, array, 8);
	printf("ADC value from Mux 0x%02x : 0x%04x (%s)\n", mux, value,
	{ "adc",       cmd_adc,       "<mux>",               "Read ADC value of
<mux> input"  },
--

Anyhow, will fix and re-submit. Thanks,
Simon.

