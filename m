Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
Date: Wed, 22 Jun 2011 12:27:47 +0200
Message-ID: <BANLkTi=Qb7-kx0Kr6i7FXGfuNM=uDqeh+A@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

(cut)
>
> I understand why you used this type (keeps the thermometer transcodable through this
> API and there are the special values), so BTW the lack of device information service
> access through this API should at least be mentioned, so we ammend that later (either
> here or adding another API).

I don't forget the DIS issue but so far I think it's better address a
part of the problem, when we fix the thermomether API we must treat
this one. Let's split the problem in subproblems ;)

Regards.
