Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120524081405.GA30941@joana>
References: <20120524081405.GA30941@joana>
Date: Fri, 25 May 2012 11:41:46 -0300
Message-ID: <CAAngNMZ8SzpFkhQL-OzTUu4oDOiLYzYEy2qbXhg2VNiNnV5_1w@mail.gmail.com>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 24, 2012 at 5:14 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
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

attrib needs a bit of reorganization as well. tl;dr: we need to figure
how to do it.

gatttool should be moved from attrib to tools, and we're not
completely sure where to put the rest of it. The code there implements
the generic attribute API, which register a D-Bus interface but is not
a profile plugin, since there is nothing to trigger its probe.
Additionally, this API is concurrent with some of the profiles we have
now implemented, so I think there should be a way to enable/disable it
based on user configuration (then it would work pretty much as a
profile, what could be an argument to move it to 'profiles', but is
not a profile from the spec point of view, which is an argument
against it).

> doc
> plugins
> scripts
> src
> test
> tools

What is the differentiation between test and tools? It seems at least
part of tests (simple-agent for example) looks more like a tool than
like a simple test script.

> unit

Why not move unit tests to tests as well?

>
>
> In the end we will have 10 folders instead of 28 in the current configuration.
> Folders like 'tools' can also be reorganized.
>

I'm really supportive of this idea.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
