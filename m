Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: ATT/GATT shared code (Re: [PATCH BlueZ v3 06/16] attrib: Change g_attrib_set_destroy_function return type)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_PXxz2idnQvSzc7NCL3Y=hzoAPRmf_2tpz70qjUeDqZ6Q@mail.gmail.com>
Date: Fri, 3 May 2013 11:52:43 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <87E60651-8C57-4431-9129-0BACF5CF714F@holtmann.org>
References: <CAJdJm_MNgzqquKHCtrDPjU3OaaLba6zb=kwCjUnUm-qNccevpw@mail.gmail.com> <AE3F5471-8387-4451-A851-47E5FAAB4521@holtmann.org> <CAJdJm_PXxz2idnQvSzc7NCL3Y=hzoAPRmf_2tpz70qjUeDqZ6Q@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>>> We have been working recently on cleaning up GATT/ATT code and
>>> implementing unit tests for it (as you can see from our latest patches
>>> in BlueZ). Is this unpublished code based on existing code, or
>>> something written from scratch? If the latter, I think we should not
>>> spend time on cleaning up existing GATT code.
>> 
>> it is from scratch code and also possible throw away code. It does nothing useful so far. However one think became pretty clear, the current gattrib needs massive cleanups. Not just a little bit. Especially when it comes to where GATT server is located and where GATT client.
> 
> Do you mean the location on bluez tree (i.e. server code in
> src/attrib-server.c vs. client code in attrib/*)?

I am talking about both. It should not really be separated.

> What do you think of moving the attribute server to src/shared/* as
> well (after a bit of refactoring to become more pluggable)? At least
> gatttool can reuse it, as so far it has no ability to handle GATT
> requests, and therefore is not usable when connecting to clients that
> issue GATT requests.

Everything under src/shared/ I want to be LGPL licensed. Keep that in mind.

>> I want to be able to create unit tests that simulate PTS and also extra unit tests that test the raw ATT protocol and GATT procedures. That is the basic goal here.
> 
> I agree that exercising the ATT protocol separately is a good idea.
> Specially corner cases on encoding/decoding.
> 
> IMHO the PTS GATT tests are not exhaustive. We could add tests that
> imitate them, but they tend to exercise only well behaved PDUs. Except
> for standard ATT errors, error paths are poorly tested with PTS. But
> it is a start.

Of course PTS is too focused on positive testing, but that is the testing we need to be able to quickly reproduced. The important negative testing we have to add on top of it.

> We will flush our latest development on GATT (including unit tests) to
> the mailing list and later we (or someone else interested) can improve
> on top of it to add more tests.

Send the patches around.

Regards

Marcel

