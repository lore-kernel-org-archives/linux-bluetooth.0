Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Aug 2013 13:39:58 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Richard Neill <rn214@richardneill.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to test/debug bluetooth advertising [with hciconfig]?
Message-ID: <20130828103920.GD15469@aemeltch-MOBL1>
References: <521DCF49.5020807@richardneill.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <521DCF49.5020807@richardneill.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Richard,

On Wed, Aug 28, 2013 at 11:22:01AM +0100, Richard Neill wrote:
> Dear All,
> 
> I'm trying to get "hello world" working from the shell between 2
> Bluetooth 4 dongles, in LE advertising mode. I wonder whether I
> could ask for some pointers?
> 
> As I understand it, Bluetooth low-energy supports up to 31 bytes of
> arbitrary text in the advertising packet. So it should be possible
> to set one dongle up in LE-advertising mode, and a second in LE-scan
> mode, and to transfer the "hello world" message from one to the
> other.
> 
> I'm rather stuck at the moment. I've discovered that there is an "LE
> Set Advertising Data" command, 0xcf (from "hciconfig hci0
> commands_list"), and that "hcitool -i hci0 cmd 0xcf XXX YYY ZZZ" is
$ hcitool cmd --help
Usage:
	cmd <ogf> <ocf> [parameters]

Check ogf and ocf from the Bluetooth Specification.

Best regards 
Andrei Emeltchenko 

