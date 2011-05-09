Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP: Any Bluez Sample C code for Health sink?
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <492322.54247.qm@web111608.mail.gq1.yahoo.com>
Date: Mon, 9 May 2011 09:11:55 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <53036801-BEF0-4088-BE8B-BFE7A1C6F1AA@signove.com>
References: <492322.54247.qm@web111608.mail.gq1.yahoo.com>
To: Phaneeth Kumar <phaneeth@yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 8 May 2011, at 20:56 , Phaneeth Kumar wrote:

> Hi All,
> 
> I am new to the whole DBus way of accessing API and the  Bluez Health API. I am 
> trying to build a generic HDP sink in C and I am  totally lost.
> All the sample codes that I find are in Python and scripting isn't really an 
> option for this application.
> Is there any sample C code available that uses Bluez in general and HDP 
> interface in Bluez in particular?

It is not a textbook example, but Antidote's HDP plug-in does use HDP D-Bus
API and it is written in C:

http://gitorious.org/antidote/antidote/blobs/master/src/communication/plugin

bluez/plugin_bluez.c and other sources in the same folder.