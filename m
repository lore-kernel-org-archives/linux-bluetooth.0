Return-Path: <SRS0=uVZl=3N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7DC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 16:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226D2070A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 16:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgAXQk5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:40:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50447 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgAXQk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jan 2020 11:40:57 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C37DACED10;
        Fri, 24 Jan 2020 17:50:15 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2] bluetooth: Refactoring mgmt cmd op_code structure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_UpVApmeKy=679yGM7-Z62Kbd9Pj=9Xyy8FzjC3aHMkkg@mail.gmail.com>
Date:   Fri, 24 Jan 2020 17:40:55 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9D8E5673-048E-408C-B55E-37BA60F40B00@holtmann.org>
References: <20200118050410.257697-1-alainm@chromium.org>
 <37FDD376-5D3D-484C-9209-B59FACA22D0A@holtmann.org>
 <CALWDO_XWvfzRPQ0Ybnpe-x+mw-amrTOMP=PjUpDg0jnXVFRi-w@mail.gmail.com>
 <F6B3CCC4-592C-4F9B-A87B-AC1FF1CB9A78@holtmann.org>
 <CALWDO_VdPWaSa8MF-y5wB+h9EV9+=vSaPWXu64F+p0crqO84OA@mail.gmail.com>
 <6EF3C3FB-89A6-4B23-A4F5-ADC59FFB9F98@holtmann.org>
 <CALWDO_UpVApmeKy=679yGM7-Z62Kbd9Pj=9Xyy8FzjC3aHMkkg@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> I'll separate the simple one liner into a separate patch then will
>>> wait for your suggestion for the rest.  Note that with a single jump
>>> table as suggested, it will indeed allow us to defunc some op-codes
>>> pretty easily.
>> 
>> I have not fully thought this through yet, but here it goes.
>> 
>> The read_version and read_commands are special since they have to be present no matter what. So on purpose we put these two commands first when we designed the API back in the days. We can special handle them and thus also avoid the forward declaration. I am leaning towards this direction since we might want to actually split commands over multiple files to keep this file readable over time.
>> 
>> Now the downside with putting the opcode as a field in the data structure is that we actually have to look through the every field until we find the opcode and can not just jump to the position defined by that opcode. That means actually filling the table with NULL pointers for not supported or disable commands might be better. We could still make the read_commands function map the list of supported commands from that table.
> That may be an acceptable compromise.  At least there would be exactly
> one place to make sure things are aligned.  Perhaps we could also
> leave the op-codes in place and create a test that ensures that if
> !NULL then op_code == index.

I don’t understand this? If you would have test cases in mgmt-tester any error would be caught quickly.

Regards

Marcel

