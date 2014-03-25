Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Mar 2014 10:53:34 +0800
From: guchaojie <chao.jie.gu@intel.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: issues on gatt dbus searching primary service
Message-ID: <20140325025334.GA16017@guchaojie-HP>
References: <20140324081445.GB6943@guchaojie-HP>
 <CAKT1EBeLnVaW2GSxQP8NRoiWjQL_5gJnrbe03kv6sKtDaNDg5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKT1EBeLnVaW2GSxQP8NRoiWjQL_5gJnrbe03kv6sKtDaNDg5A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 24, 2014 at 10:56:30AM -0300, Claudio Takahasi wrote:
> Hi Chaojie Gu,
> 
> On Mon, Mar 24, 2014 at 5:14 AM, guchaojie <chao.jie.gu@intel.com> wrote:
> > hi, claudio:
> >     We are working on development of bluetooth LE gatt client feature in
> >  bluetooth-frwk on Tizen platform.
> >      We notice you have done a lot of work on this aspect and submit related
> > patches. In the release of bluez version, gatt-api.txt told us we can reach
> > the gatt service , characteristic and descriptor by th DBus export object
> > path hierachy.
> >     There is one issue when we develop the one feature about searching primary
> > services, we notice under the interface of org.bluez.GattService1 under which
> > there is only 128-bit UUID. This UUID should be attrbute value of service.
> > One key point, how can we know service type is primary through attribute type?
> 
> Indeed, the API needs to be extended to expose the service type.
> 
> > In the release of DBus Hierachy in gatt-api.txt, we cannot judge whether the
> > service type is primary or something like secondary, included service.
> > We have to know the org.bluez.GattService under the object path of service
> > defaultly refer to primary service or add a property of attribute type to
> > help user to judge the service type.
> >
> > Thanks
> > Chaojie Gu
> 
> 
> A primary service can also include another primary service, so
> "Includes" property is not enough to figure out if the service is
> primary or secondary.
> 
> We need to propose an extension that makes Server and Client
> consistent. Feel free to send a proposal in the ML.
> 
> Regards,
> Claudio

Hi Claudio,
    Thanks for your reply sincerely. In my proposal, there are two properties need to be
 extended to org.bluez.GattService1.
    One point you have figure out is service type, according to "Includes"
property is not enough to judge the service type.
    Another proposal is that maybe one device connect to multiple LE devices , so
under the interface of org.bluezGattService1, it better to expose the object
Device such as object Service exposed under the org.bluez.GattCharacteristic1.
there will be clear GATT Dbus hierarchy and more easier for user to use.

Thanks
Chaojie Gu
