Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120524081405.GA30941@joana>
References: <20120524081405.GA30941@joana>
Date: Thu, 24 May 2012 11:20:11 +0300
Message-ID: <CABBYNZLhWfS6Ff0S8SkCwSXxzt61NzNCBH-K78hQB6dtpPvJ6Q@mail.gmail.com>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 24, 2012 at 11:14 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Everyone,
>
> The last profiles addition to BlueZ increased a lot the number of folders we
> have in the root dir of the project and it looks like more profiles (and more
> folders) are expected to come.
>
> I talked a bit with Johan about changing the hierarchy of the BlueZ tree and
> the following proposal where 2 new folders are created, 'profiles' and 'libs'
> and things are moved to them.
>
> compat          -> /dev/null (will be removed on 5.0)
> alert           -> profiles
> audio           -> profiles
> cups            -> profiles
> deviceinfo      -> profiles
> health          -> profiles
> input           -> profiles
> lib             -> profiles
> network         -> profiles
> proximity       -> profiles
> sap             -> profiles
> serial          -> profiles
> thermometer     -> profiles
> time            -> profiles
> btio            -> libs
> gdbus           -> libs
> sbc             -> libs
> emulator        -> tools
> mgmt            -> tools
> monitor         -> tools
> attrib
> doc
> plugins
> scripts
> src
> test
> tools
> unit

Sounds good, the only problem are gdbus and btio, if we merge obexd
into BlueZ btio will no longer be shared but for gdbus we would have
to align with other projects as well.

-- 
Luiz Augusto von Dentz
