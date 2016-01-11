Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Creating BLE Server application with BlueZ
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <TU4PR84MB031993F9D5F95A651BCFBC65CDF30@TU4PR84MB0319.NAMPRD84.PROD.OUTLOOK.COM>
Date: Mon, 11 Jan 2016 10:20:23 -0800
Message-Id: <C040B48C-6300-4DB1-8535-E064C2AA7632@gmail.com>
References: <TU4PR84MB031993F9D5F95A651BCFBC65CDF30@TU4PR84MB0319.NAMPRD84.PROD.OUTLOOK.COM>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Jan 5, 2016, at 10:36 AM, Stanbro, Matthew A. <matthew.a.stanbro@hp.com> wrote:
> 
> Hello Everyone,
> 
> I am new to working with BlueZ and I am trying to get a handle on how to create a BLE service and add characteristics. Looking around the web I can find quite a bit of information about using BlueZ as a BLE client for connecting to other BLE devices to read/write attributes, but I am struggling to find anything which helps explain creating a BLE service and dealing with advertising. Can anyone point me to a resource for learning to work with the BlueZ C api for creating/starting/stopping services, adding/modifying characteristics, starting/stopping/modifying advertisments? Thanks in advance for any help you can offer.

Matthew,

Are you wanting to use a C program to do your BLE stuff? Or are open to writing a python one? I’m currently trying to work through the same issues, but using python as the glue to configure/manage the service/characteristic.

