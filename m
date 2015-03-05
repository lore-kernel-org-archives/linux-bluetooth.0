Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: DBus API for LTK OOB keys
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54F862A3.80400@ubnt.com>
Date: Thu, 5 Mar 2015 06:55:05 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <8EB5FD2F-4C46-41F8-95BA-4ACBEF0BCDE4@holtmann.org>
References: <54F8584D.6020301@ubnt.com> <20150305134024.GA20862@t440s> <54F862A3.80400@ubnt.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

>>>     There is a MGMT "Load Long Term Keys Command" to feed keys to the Kernel
>>> which are stored in the BlueZ settings storage file and read during adapter
>>> init (load_devices->load_ltks). I searched through the code and couldn't
>>> find any means to feed LTK keys from "the outside", for example through DBus
>>> API. This is needed for an LE OOB pairing scheme, when key is known in
>>> advance by both parties and is not derived from pairing procedure. Is there
>>> a standardized way to add LTK keys "manually" or this is not supported-yet
>>> feature? According to setting storage rules "Direct access to the storage
>>> outside from bluetoothd is highly discouraged".
>> Are the keys provisioned beforehand or is this something that can happen
>> at any time when bluetoothd is already running? If it's the former then
>> a custom bluetoothd plugin that gives bluetoothd core an extra set of
>> keys could be one way to go. If it's the latter, then things get tricky
>> since the mgmt command wipes all existing keys away before adding new
>> ones.
> In my particular scenario, the OOB key is provisioned only once and beforehand and used to connect with multiple LE devices. LE devices get this key via some proprietary mechanism. So it is kind of "global master key". As such, it is not a problem to restart the BlueZ daemon after the key is (re-)provisioned.

using the same LTK for multi devices is a really bad idea. This is not how Bluetooth LE security was designed. My advise would be strictly against doing that in any product.

>> If your OOB scheme is this latter "non-pre-provisioned" one I'd wonder
>> why you're not using the standard OOB mechanism provided by LE SMP,
>> since for that we do have at least partial support.
> I'm now confused a bit. Indeed, I want to use OOB mechanism provided by LE SMP, but in order to start OOB pairing, the OOB key itself should be known to both sides (central and peripheral). For the peripheral I have my own ways to do it (proprietary), but the main question it how to give the key value to the central which is BlueZ in this case.

When using LE OOB pairing (Legacy Pairing and Secure Connections), then at least you get a sense of key strength that is guaranteed based on how LE security is designed. So doing LE OOB pairing is a good idea. You feed different information into OOB pairing. You share and OOB secret between two devices and based on that they can pair. However they need to be in range to actually use that OOB secret to pair. Pairing requires a connection. The advantage with pairing is that you get a proper key with a proper strength.

Regards

Marcel

