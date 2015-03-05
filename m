Return-Path: <cyrus@holtmann.org>
Message-ID: <54F862A3.80400@ubnt.com>
Date: Thu, 05 Mar 2015 16:05:23 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DBus API for LTK OOB keys
References: <54F8584D.6020301@ubnt.com> <20150305134024.GA20862@t440s>
In-Reply-To: <20150305134024.GA20862@t440s>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 2015.03.05. 15:40, Johan Hedberg wrote:
> Hi Andrejs,
>
> On Thu, Mar 05, 2015, Andrejs Hanins wrote:
>>      There is a MGMT "Load Long Term Keys Command" to feed keys to the Kernel
>> which are stored in the BlueZ settings storage file and read during adapter
>> init (load_devices->load_ltks). I searched through the code and couldn't
>> find any means to feed LTK keys from "the outside", for example through DBus
>> API. This is needed for an LE OOB pairing scheme, when key is known in
>> advance by both parties and is not derived from pairing procedure. Is there
>> a standardized way to add LTK keys "manually" or this is not supported-yet
>> feature? According to setting storage rules "Direct access to the storage
>> outside from bluetoothd is highly discouraged".
> Are the keys provisioned beforehand or is this something that can happen
> at any time when bluetoothd is already running? If it's the former then
> a custom bluetoothd plugin that gives bluetoothd core an extra set of
> keys could be one way to go. If it's the latter, then things get tricky
> since the mgmt command wipes all existing keys away before adding new
> ones.
In my particular scenario, the OOB key is provisioned only once and 
beforehand and used to connect with multiple LE devices. LE devices get 
this key via some proprietary mechanism. So it is kind of "global master 
key". As such, it is not a problem to restart the BlueZ daemon after the 
key is (re-)provisioned.
>
> If your OOB scheme is this latter "non-pre-provisioned" one I'd wonder
> why you're not using the standard OOB mechanism provided by LE SMP,
> since for that we do have at least partial support.
I'm now confused a bit. Indeed, I want to use OOB mechanism provided by 
LE SMP, but in order to start OOB pairing, the OOB key itself should be 
known to both sides (central and peripheral). For the peripheral I have 
my own ways to do it (proprietary), but the main question it how to give 
the key value to the central which is BlueZ in this case.
>
> Johan

