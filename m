Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90B1DB356
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297575; cv=none; b=H2Qc8/DkL8GD6rcC8y4iyQK3CQS5Hj/xmJli4eGIxA/B7pcJpSwh1IfFoULYSHStXubX2aDQ6RqpMfFpWbW2E7egN6asvZRu/d5WodPhL34Nrf/17O3LP5kEbvW9GuvbMEiX4Ecgd3xHgOYO5Fws7jlf2Yw3bzgWqFB/JKP9H64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297575; c=relaxed/simple;
	bh=HOAWa7GWK96jZxFd58CjZI8Wx1nZM8r8b5PmGPyvjTk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=F7486dkgARWJumewl0K/I0UJhHVcKyz2QXV/XLj/FOSqpWJgouTs5LDKzcAMxDiZ47zFYb+q9Q6YdfzB8SqU7LgmmgJ7JmxuxnaShSqyF7u6JYj8+dKOTdH4D7s+qVocKq3ejm5hpADJcbRW7KLsdoLh56w3erPLITNbzdU0Xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 4.e.a.4.5.c.0.3.2.3.9.a.4.c.6.8.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:86c4:a932:30c5:4ae4] helo=[IPV6:fd34:5ae5:dfe:ae11::1])
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u2tTk-000Ka4-2E
	for linux-bluetooth@vger.kernel.org;
	Thu, 10 Apr 2025 16:06:08 +0100
Message-ID: <1583c664-14f3-4ee1-a56c-f5de3f7d7e5e@pileofstuff.org>
Date: Thu, 10 Apr 2025 16:05:59 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: security@bluez.org doesn't work
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've spent two weeks trying to report a bug in bluez that may have security
implications, with no evidence of success.  The details of the issue aren't
relevant to the problem, so I'll just say I'm not a security professional
and can't say for certain whether the bug is actually a security problem.

https://www.bluez.org/development/ has a section "security bugs" with a link
labelled "handling the security bug of BlueZ".

That link points to https://www.bluez.org/development/security-bugs/,
which says "The BlueZ security team can be contacted by email at
security@bluez.org".

I sent an e-mail to security@bluez.org on 2025-03-26, and got an 
automatic reply
on 2025-03-31 saying the message couldn't be delivered:

 > This is the mail system at host mail.holtmann.org.
 >
 > I'm sorry to have to inform you that your message could not
 > be delivered to one or more recipients. It's attached below.
 >
 > For further assistance, please send mail to postmaster.
 >
 > If you do so, please include this problem report. You can
 > delete your own text from the attached returned message.
 >
 >                    The mail system
 >
 > <(address hidden)> (expanded from <security@bluez.org>): host
 >     alt1.aspmx.l.google.com[142.250.153.27] said: 550-5.7.26 Your 
email has
 >     been blocked because the sender is unauthenticated. 550-5.7.26 Gmail
 >     requires all senders to authenticate with either SPF or DKIM. 
550-5.7.26
 >     550-5.7.26  Authentication results: 550-5.7.26  DKIM = did not pass
 >     550-5.7.26  SPF [pileofstuff.org] with ip: [212.227.132.17] = did 
not pass
 >     550-5.7.26  550-5.7.26  For instructions on setting up 
authentication, go
 >     to 550 5.7.26 
https://support.google.com/mail/answer/81126#authentication
 >     a640c23a62f3a-ac7195f9db3si563836466b.529 - gsmtp (in reply to 
end of DATA
 >     command)
 >
 >
 > Reporting-MTA: dns; mail.holtmann.org
 > X-Postfix-Queue-ID: 2A99FCECD8
 > X-Postfix-Sender: rfc822; kernel.org@pileofstuff.org
 > Arrival-Date: Wed, 26 Mar 2025 16:42:16 +0100 (CET)
 >
 > Final-Recipient: rfc822; (address hidden)
 > Original-Recipient: rfc822;security@bluez.org
 > Action: failed
 > Status: 4.7.26
 > Remote-MTA: dns; alt1.aspmx.l.google.com
 > Diagnostic-Code: smtp; 550-5.7.26 Your email has been blocked because the
 >     sender is unauthenticated. 550-5.7.26 Gmail requires all senders to
 >     authenticate with either SPF or DKIM. 550-5.7.26 550-5.7.26
 >     Authentication results: 550-5.7.26  DKIM = did not pass 
550-5.7.26  SPF
 >     [pileofstuff.org] with ip: [212.227.132.17] = did not pass 550-5.7.26
 >     550-5.7.26  For instructions on setting up authentication, go to 
550 5.7.26
 >     https://support.google.com/mail/answer/81126#authentication
 >     a640c23a62f3a-ac7195f9db3si563836466b.529 - gsmtp
 >

Note: I have replaced the actual address with "(address hidden)" above,
as I'm not sure whether this address was supposed to be made public.

So far as I can tell, the message above means mail.holtmann.org is 
attempting
to send e-mails claiming to be from my domain, and correctly being blocked
by Google because I haven't authorised it to do so.

I then sent the bug report and the above issue directly to the hidden 
address
on 2025-04-03, but have not yet received a reply.

Could you let me know the correct process to report security issues and how
long I should expect to wait before acknowledgement?  Also, can you put
that information on the website for the next person who comes along?
