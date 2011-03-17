Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <hombre71@gmail.com>
CC: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Thu, 17 Mar 2011 11:50:28 +0200
Subject: RE: [PATCH v5 2/4] Add support for SAP protocol
Message-ID: <99B09243E1A5DA4898CDD8B70011144810830AAEF3@EXMB04.eu.tieto.com>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1300277421-8053-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <AANLkTinF695CSLoSgxCn1LOiZ=jF-Z8OjAsEeY52K8GG@mail.gmail.com>
In-Reply-To: <AANLkTinF695CSLoSgxCn1LOiZ=jF-Z8OjAsEeY52K8GG@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Angus.H,

>A lot of code could be refactored.
>Quite a few repeatable (logically) blocks in every 
>"...._req()" and "..._rsp()" handlers.
>

Indeed, but those blocks are not equal in all cases. Thus, I prefere to split it up into seperate functions instead of having one big function with switch-case statement.
It's not like we can replace those blocks with one generic function without switch-case.  I consider this as slightly more readable. However, I'm not strongly opposed to change it one function.

Waldek
