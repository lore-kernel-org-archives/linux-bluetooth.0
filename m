Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Mar 2015 15:40:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DBus API for LTK OOB keys
Message-ID: <20150305134024.GA20862@t440s>
References: <54F8584D.6020301@ubnt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54F8584D.6020301@ubnt.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Thu, Mar 05, 2015, Andrejs Hanins wrote:
>     There is a MGMT "Load Long Term Keys Command" to feed keys to the Kernel
> which are stored in the BlueZ settings storage file and read during adapter
> init (load_devices->load_ltks). I searched through the code and couldn't
> find any means to feed LTK keys from "the outside", for example through DBus
> API. This is needed for an LE OOB pairing scheme, when key is known in
> advance by both parties and is not derived from pairing procedure. Is there
> a standardized way to add LTK keys "manually" or this is not supported-yet
> feature? According to setting storage rules "Direct access to the storage
> outside from bluetoothd is highly discouraged".

Are the keys provisioned beforehand or is this something that can happen
at any time when bluetoothd is already running? If it's the former then
a custom bluetoothd plugin that gives bluetoothd core an extra set of
keys could be one way to go. If it's the latter, then things get tricky
since the mgmt command wipes all existing keys away before adding new
ones.

If your OOB scheme is this latter "non-pre-provisioned" one I'd wonder
why you're not using the standard OOB mechanism provided by LE SMP,
since for that we do have at least partial support.

Johan
