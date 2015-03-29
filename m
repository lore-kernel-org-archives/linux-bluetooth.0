Return-Path: <cyrus@holtmann.org>
Message-ID: <55188985.80001@gmail.com>
Date: Mon, 30 Mar 2015 01:23:49 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Multi-Advertising: implementation options, timing questions
References: <5515ECE9.9080101@gmail.com>	<0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org>	<55164DEC.6070009@gmail.com>	<E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org>	<5516AD7C.3040401@gmail.com> <CAHrH25RbwtPDgLuRNVa92a=5+y5beMYgzrJLfwf19ut-T=cANA@mail.gmail.com>
In-Reply-To: <CAHrH25RbwtPDgLuRNVa92a=5+y5beMYgzrJLfwf19ut-T=cANA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

 > Now that most of the logic for a single instance is in place it should
> be straightforward to extend it for multiple instances. I would start
> by turning the adv_instance field of hci_dev into a list of
> adv_instances and a way to determine and get a pointer to the
> currently active instance.

Yes, agreed. That's exactly where I started. Happy to hear that you got 
the same procedure in mind. I experimented with a dynamically extended 
array and a linked list. The latter seems to be the better choice as it 
allows us to easily remove entries in the middle of the list.

> You would then modify the code in
> net/bluetooth/mgmt.c that accesses the instance 1 parameters to use
> the new getter instead. Once all of that is done, the second step
> would be a matter of inserting new elements into the advertising list
> and handling the round-robin logic and the duration parameter.

Agreed. That's what I had in mind, too.

> If it makes things easier I can start tackling the first step which is
> mostly refactoring my recent code to enable multiple instances. You
> can then cleanly build the multiple instance logic on top of that.

It's up to you. Just let me know so that I don't interfere with your 
work. I don't want to block you as I'll certainly take much longer to 
get it right (newbie + evenings/weekends only). Today I just set up my 
dev env and made the build + e2e-tests run on a vm with a minimal 
kernel. So not much done in the code, yet.

Apart from that I got a few thoughts while familiarizing myself with the 
source that you might be able to comment on:

- Why do we have two flags to distinguish between multi- and 
single-instance advertising (HCI_ADVERTISING[_INSTANCE])? Doesn't that 
allow for inconsistencies (=both true)? Wouldn't it be better to 
interpret one as "advertising generally en-/disabled" and the other as a 
switch between single and multi adv mode? That would also allow us to 
keep track of the adv mode when advertising is temporarily disabled and 
then re-enabled. As Marcel commented this might be necessary for some 
controllers in multi-adv mode when adv data cannot be changed on-the-fly.

- What do you think of the idea to handle "set adv" and multi-adv more 
uniformly? I have the following in mind:
1) whenever an adv mode switch occurs, all current adv instances will be 
canceled and destroyed
2) "set adv" will add/replace a single instance to the list
3) "add adv" will add instances up to max_instances
This would probably dry up the code and duplicate memory structures 
quite a bit and also remove some logic quirks.

- Instances are currently being identified by an integer 
"adv_info.instance". When we add instances more dynamically would it not 
be better to pass pointers around and get rid of that integer? That 
would remove the necessity to keep track of, synchronize and verify 
instance ids.

- The mgmt_rp_read_adv_features structure contains an unused 
instance[0]. Seems to be redundant and could be removed, right?

Well, that's it for the moment. Thanks for being so friendly to a newcomer.

Florian
