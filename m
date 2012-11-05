Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/3] LE Connection parameter tuning (first step)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 05 Nov 2012 14:42:27 +0100
From: Kim Schulz <kim@schulz.dk>
In-Reply-To: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
Message-ID: <2375c7de623938c6e2f1fe8e7687db7d@server1.devteam.dk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Den 2012-11-05 14:25, Vinicius Costa Gomes skrev:
> Hi,
>
> Right now, we are using only one set of (hardcoded) connection
> parameters for LE.  I guess the first step to have different
> connection parameters classes for different Profiles requirements
> (think "Low Latency", "Low Power", etc.) is to have a nice set of
> parameters. For that we need to measure and see which are the sweet
> spots, This series aims to help the measuring part.
>
> This is an idea so we can easily change the connection parameters
> without need for recompiling the kernel side, so tests can be more
> practical.
>
[snip]


Good idea to split them out as every single profile defines their own. 
Have you
concidered what should happen if two LE connections to two different 
profils should
happen at the same time and the connection parameters are different? 
i.e. should bluez
maybe have a per-profile set of connection parameters?
Also make room in the struct for Preferred Connection Paramters (the 
values read
from the peer DB after connection) as these can differ from the ones 
the profile proposes.

-- 
Kim Schulz
