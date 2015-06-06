Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Add routine for applying Intel DDC parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150526094322.763b217f@tedd-fedora-vm>
Date: Sat, 6 Jun 2015 07:51:39 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <C7A13318-0490-42BE-80BD-F7AD0AC6036D@holtmann.org>
References: <20150520140409.5a3317f5@tedd-fedora-vm> <37510C75-1090-4601-AC8F-AC46800753C1@holtmann.org> <20150526094322.763b217f@tedd-fedora-vm>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

>>> This patch adds the routine to apply the DDC parameter from device
>>> specific ddc file.
>>> 
>>> Once the device is rest to operational mode, optionally, it can
>>> download the device specific configration (DDC) parameters before
>>> the BlueZ starts the stack initialization.
>>> 
>>> It opens the DDC file based on HW_VARIANT and send ID/Value with
>>> HCI_Intel_Write_DDC command.
>>> 
>>> Format of DDC file
>>> DDC file consists of one or more number of DDC structure that has a
>>> 'Length' field of one octet, DDC 'ID' field of two octets followed by
>>> the array of DDC 'Value' that gives the value of parameters itself.
>>> 'Length' contains the length of DDC 'ID' and DDC 'Value'.
>>> 
>>> +------------+----------+
>>> | Size(byte) |    Name  |
>>> +------------+----------+
>>> |      1     | Length   |
>>> +------------+----------+
>>> |      2     | ID       |
>>> +------------+----------+
>>> | Length - 2 | Value    |
>>> +------------+----------+
>> 
>> I wonder if we should add some sort of header to this file structure.
>> 
> 
> Could you explain more about the "header"? DDC header is Length and ID.
> The DDC file can have more than one DDC. Do you mean the header for all DDC
> contents? Then it will be same as HCI plen.

I meant a general file header. Some magic bytes that identity this as DDC file. Not sure if this is needed or not. Otherwise for each DDC entry, I am totally fine in using the format of the HCI command itself as base for the data. That will make it really simple.

> Also, how do you think about saving this file in ASCII format instead of binary?
> then I can add some comments that start with # and ignore the line like bash script.

We can easily extend bluemoon utility to convert this from some kind of key value pair ASCII format. However in general the binary format is a bit more efficient from the kernel point of view.

Regards

Marcel

