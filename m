Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed api (ver 0.2)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <n2haa32413d1005071351qb6db6039u7caab57a5e893884@mail.gmail.com>
Date: Fri, 7 May 2010 18:08:36 -0300
Cc: jcaden@libresoft.es, linux-bluetooth@vger.kernel.org
Message-Id: <32F45991-49B0-4B46-84C0-789A3B1D8766@signove.com>
References: <201005051255.09394.jcaden@libresoft.es> <3CCD92AC-1578-4E78-AEE8-80AEE73511EB@signove.com>  <201005071203.23882.jcaden@libresoft.es> <2541510E-4912-4AEB-AEFB-83F4339EC3FA@signove.com> <n2haa32413d1005071351qb6db6039u7caab57a5e893884@mail.gmail.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> 
> Device objects exists for each paired device. If the pairing is
> removed the object is also removed and a new pairing is needed before
> connecting to it (as imposed by the whole bluetooth stack logic
> anyway).

AFAIK the HDP source and sink must be paired before any session can be established, so the relevant device objects will always be there, so the path can be (re)used.

> Re-using the device path and adding sessions as sub-paths seems
> reasonable, but I would wait on comments from Johan / Luiz / Marcel if
> this is desirable or might have any side-implication before defining
> this topic as closed.
