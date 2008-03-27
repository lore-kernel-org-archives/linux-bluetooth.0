Return-Path: <cyrus@holtmann.org>
Message-ID: <47EB7AC4.30700@access-company.com>
Date: Thu, 27 Mar 2008 11:45:24 +0100
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EA7502.0@access-company.com>
	<D1F8014E-5892-4B2A-9219-99670FC1EA60@holtmann.org>
In-Reply-To: <D1F8014E-5892-4B2A-9219-99670FC1EA60@holtmann.org>
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

Hello Marcel,

>> - currently, when performing a CreateDevice, input service connects  
>> then
>> disconnects from remote device. This makes some tests failed.
>> What do you think if this does not disconnect (and create classic  
>> device
>> connection) ?
> 
> does using CreateSecureDevice helps? Can you verify with bluez- 
> utils-3.29 and see if it is still a problem?

I tried with CreateSecureDevice and latest 3.29 version but PTS tests failed.
I think this is related to the disconnection in Create*Device process.
What do you think if disconnection is removed from this process ? Or add a new API, something like CreateAndConnectSecureDevice ?

>> - when kernel (2.6.22) receives a VIRTUAL_CABLE_UNPLUG from PTS (tests
>> TC_HOS_HCR_BV_02_I and TC_HOS_HCR_BV_04_I) it does not close the L2CAP
>> channels as PTS waits for.
>> I take a look in 2.6.22 sources, and it seems to me this disconnection
>> should happen, am I right ?
>> Is it fixed in later kernel ?
> 
> I recall that there was a fix for this.

Do you remember if this has been integrated in kernel ?
I take a look to latest kernel (2.6.24) and do not see any change that seems to be related to this problem.

Thanks

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
