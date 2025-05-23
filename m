Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5265EC2
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017903; cv=none; b=LS6aD3VTnS+zbtA8xea4RxL+QNGNQL9ZKYqxWaO3qX231vNOPeXygU6t9rLZAw/KkLBg/yPDDY5DFMcNZa7CzBrEe4e4vJV1ijGQZBK3Tv537G4p7NK9xPmCgBi3o2fJWvAap9Q8oY1GUEmhERV3/EHiiKFHVagKGuwX7xjszpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017903; c=relaxed/simple;
	bh=bIcwa8E1mZlM2OGTjps6+LU5JmRzL5q9Sr608a0JlNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6q9pCoMIHYkWBCyPxy8HWT+CNNVguaoer2NUl+EUO4RPrZRGIy/o6Ub0lXgL4ZhHPjZBnC1l+2vTNLSpYqyxaqgKBSQJcFUlmMiF+iHnM58MKi3tYiY6gjhthZDYRae7yc6TRp1uDhaDkbao4aeSJVa/Yj9c2rxn0UOAHzuQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 5.5.b.7.3.b.f.b.f.e.2.7.1.c.8.c.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:c8c1:72ef:bfb3:7b55] helo=andrews-2024-laptop.sayers)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uIVJ1-003ahA-20;
	Fri, 23 May 2025 17:31:35 +0100
Date: Fri, 23 May 2025 17:31:33 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>
Cc: luiz.dentz@gmail.com, pav@iki.fi, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v6 1/3] obexd: Unregister profiles when the user is
 inactive
Message-ID: <aDCi5XGOajXmBDug@andrews-2024-laptop.sayers>
References: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
 <20250430131648.1291354-2-kernel.org@pileofstuff.org>
 <333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com>
 <aDBPCM8f0dpkJ7ob@andrews-2024-laptop.sayers>
 <8b4ed19b-0042-426a-83ea-04947edd8f0b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b4ed19b-0042-426a-83ea-04947edd8f0b@collabora.com>

On Fri, May 23, 2025 at 01:17:22PM +0200, Frédéric Danis wrote:
> Hi Andrew,
> 
> On 23/05/2025 12:33, Andrew Sayers wrote:
> 
> > On Thu, May 22, 2025 at 04:55:22PM +0200, Frédéric Danis wrote:
> > > Hi Andrew,
> > > 
> > > On 30/04/2025 15:14, Andrew Sayers wrote:
> > > 
> > > > Obexd is usually run as a user service, and can exhibit surprising
> > > > behaviour if two users are logged in at the same time.
> > > > 
> > > > Unregister profiles when the user is detected to be off-seat.
> > > > 
> > > > It may be impossible to detect whether a user is on-seat in some cases.
> > > > For example, a version of obexd compiled with systemd support might be
> > > > run outside of a systemd environment.  Warn and leave services
> > > > registered if that happens.
> > > > 
> > > > Obexd can be run as a system service, in which case this check makes no
> > > > sense.  Disable this check when called with `--system-bus`.
> > > > 
> > > > Obexd can also be run by a user that does not have an active session.
> > > > For example, someone could use `ssh` to access the system.  There might
> > > > be a use case where someone needs Bluetooth access but can't log in with
> > > > a keyboard, or there might be a security issue with doing so.  This isn't
> > > > handled explicitly by this patch, but a future patch could add support
> > > > by calling `logind_set(FALSE)` in the same way as is currently done
> > > > with `--system-bus`.
> > > > 
> > > > Unregister profiles by closing private connections instead of sending
> > > > UnregisterProfile on the shared connection.  Pipewire has apparently
> > > > found the latter to cause long shutdown delays, because bluetoothd
> > > > may be shutting down and unable to handle this message.
> > > > 
> > > > Based in large part on the wireplumber code mentioned by Pauli Virtanen:
> > > > https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52
> > > > 
> > > > Other services are likely to need similar functionality,
> > > > so I have created a gist to demonstrate the basic technique:
> > > > https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
> > > > 
> > > > Suggested-by: Pauli Virtanen <pav@iki.fi>
> > > > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > > I have a problem to connect PBAP profile using obexctl, using upstream
> > > bluetoothd and obexd built on Ubuntu 24.04, the org.bluez.obex.PhonebookAccess1
> > > interface doesn't appear.
> > > 
> > > After bisecting I found that this commit cause this issue.
> > Hmm, my guess is that seat detection isn't working properly.
> > Could you try this gist?  You should get "Active: 1" when it starts,
> > "Active: 0" when you switch away from your current screen, and "Active: 1"
> > when you switch back.
> > 
> > https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
> > 
> It seems to work:
> $ ./user-on-seat
> Active: 1
> Active: 0
> Active: 1
> 
> But the problem occurred while I didn't try any "seat" change.

Yeah, I was hoping you'd get e.g. 0 / 0 / 1 as output, suggesting it was
inactive at first but changing seats worked around the problem.
Sorry, but this means it'll be harder to debug.  Can you...

1. Check whether PBAP is registered with bluetoothctl:

       bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb

   You should see one line, like:

       UUID: Phonebook Access Client   (0000112e-0000-1000-8000-00805f9b34fb)

2. Tail the bluetooth and obex logs in another terminal:

       sudo journalctl -f SYSLOG_IDENTIFIER=bluetoothd SYSLOG_IDENTIFIER=obexd

   Steps below will ask you to "make a note" in the log
   (e.g. append "about to do XYZ" to the file) - this will tell me
   which messages were triggered by which events.

3. Make a note in the log, then stop the obex service:

       systemctl --user stop obex.service

4. Check PBAP again:

       bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb

   You should not see any output.

5. Make another note in the log, then start the obex service:

       systemctl --user start obex.service

6. Check PBAP again:

       bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb

   You should see the same as in step 1.

8. Make a final note in the log, then try ctrl+alt+F{7,8}.

9. Send me the full log with notes, or at least anything that jumps out at you

Note: the instructions above only print things that are likely to show
problems, and unlikely to contain anything that can't go in an e-mail.  You're
welcome to do `sudo journalctl -f` and or `bluetoothctl show` in another
terminal and go looking for trouble :)

> I just started bluetoothd, obexd and obexctl, then tried to connect to my phone and got:
> 
>     connect 24:24:B7:11:82:6C pbap
>     Attempting to connect to 24:24:B7:11:82:6C
>     [NEW] Session /org/bluez/obex/client/session0 [default]
>     [24:24:B7:11:82:6C]# Connection successful
> 
> While I'm expecting:
> 
>     connect 24:24:B7:11:82:6C pbap
>     Attempting to connect to 24:24:B7:11:82:6C
>     [NEW] Session /org/bluez/obex/client/session0 [default]
>     [24:24:B7:11:82:6C]# [NEW] PhonebookAccess /org/bluez/obex/client/session0
>     [24:24:B7:11:82:6C]# Connection successful
> 
> -- 
> Frédéric Danis
> Senior Software Engineer
> 
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
> Registered in England & Wales, no. 5513718
> 
> 
