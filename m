Return-Path: <cyrus@holtmann.org>
Message-Id: <70BC25E2-2162-4792-938B-4FE91F0A6032@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47EB7AC4.30700@access-company.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 16:09:12 +0100
References: <47EA7502.0@access-company.com>
	<D1F8014E-5892-4B2A-9219-99670FC1EA60@holtmann.org>
	<47EB7AC4.30700@access-company.com>
Subject: Re: [Bluez-devel] HID certification using PTS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

>>> - currently, when performing a CreateDevice, input service connects
>>> then
>>> disconnects from remote device. This makes some tests failed.
>>> What do you think if this does not disconnect (and create classic
>>> device
>>> connection) ?
>>
>> does using CreateSecureDevice helps? Can you verify with bluez-
>> utils-3.29 and see if it is still a problem?
>
> I tried with CreateSecureDevice and latest 3.29 version but PTS  
> tests failed.
> I think this is related to the disconnection in Create*Device process.
> What do you think if disconnection is removed from this process ? Or  
> add a new API, something like CreateAndConnectSecureDevice ?

can you please check the service records of the PTS. Does it set the  
reconnect value to TRUE. Please check hcidump and see if CreateDevice  
actually connects the control and interrupt PSM.

Does it help if you call CreateDevice() and then Connect() to pass the  
test.

>>> - when kernel (2.6.22) receives a VIRTUAL_CABLE_UNPLUG from PTS  
>>> (tests
>>> TC_HOS_HCR_BV_02_I and TC_HOS_HCR_BV_04_I) it does not close the  
>>> L2CAP
>>> channels as PTS waits for.
>>> I take a look in 2.6.22 sources, and it seems to me this  
>>> disconnection
>>> should happen, am I right ?
>>> Is it fixed in later kernel ?
>>
>> I recall that there was a fix for this.
>
> Do you remember if this has been integrated in kernel ?
> I take a look to latest kernel (2.6.24) and do not see any change  
> that seems to be related to this problem.

Please include the hcidump -X -V output for this case.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
