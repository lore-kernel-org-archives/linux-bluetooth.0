Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B75AA63D-0629-4B45-BBB2-C09CD7EEFB48@hadess.net>
References: <CANq1E4TMGGwiz-kGGCqGOn+A-D-msiTAb8L4Yf6kkMwrzOnn_g@mail.gmail.com>
	<B75AA63D-0629-4B45-BBB2-C09CD7EEFB48@hadess.net>
Date: Tue, 19 Mar 2013 09:04:22 +0100
Message-ID: <CANq1E4QSW0y1SC=-E6wFw6arQEUwPOdeWgaSzE2iZnXOeqD1tw@mail.gmail.com>
Subject: Re: Device selection during inquiry
From: David Herrmann <dh.herrmann@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien

On Tue, Mar 19, 2013 at 1:15 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On 19 Mar 2013, at 01:07, David Herrmann <dh.herrmann@gmail.com> wrote:
>> I tried setting the following to the same values as on a sample target device:
>>  - BT Address
>>  - device-class
>>  - inquiry-mode
>>  - device-name
>> However, that didn't change anything.
>>
>> Are there any other values that I should play with which might be used
>> by the host to identify possible target devices?
>
> Adapter MAC address. In fact, I thought that was necessary with some Wiimotes to make the bonding permanent.

As I said, I already tried changing the BD-Address to one of a target
device and it didn't change anything.

In fact, I can reliably bond with any Wii Remote without changing my
BD-Address and this already works perfectly well. But this time I want
to emulate the Wii Remote and make the Wii-Console connect to me.
I don't think that it filters Address based as I have working remotes
with the following addresses:
  00:1E:35:3B:7E:6D
  78:A2:A0:DD:F6:8A
  D8:6B:F7:0D:3C:78
  2C:10:C1:B8:84:40
  34:AF:2C:18:AC:99
I cannot see any common attribute here.

Thanks anyway!
David
