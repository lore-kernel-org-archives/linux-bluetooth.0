Return-Path: <cyrus@holtmann.org>
Message-ID: <4781EE5D.1000105@gmail.com>
Date: Mon, 07 Jan 2008 18:18:21 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>	<20080102151642.GA7273@boogie.lpds.sztaki.hu>	<20080105075039.GF27894@ZenIV.linux.org.uk>	<477F9481.2040505@gmail.com>	<20080105194510.GK27894@ZenIV.linux.org.uk>	<478037F8.8020103@gmail.com>
	<47819079.3000606@gmail.com>
	<m1abnikpuz.fsf@ebiederm.dsl.xmission.com>
	<4781EE20.6070701@gmail.com>
In-Reply-To: <4781EE20.6070701@gmail.com>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net,
	Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Tejun Heo wrote:
> Eric W. Biederman wrote:
>>> That said, the mechanism is a bit too fragile.  sysfs currently ensures
>>> that dentry/inode point to the associated sysfs_dirent.  This is mainly
>>> remanent of conversion from previous VFS based implementation.  I think
>>> the right thing to do here is to make sysfs behave like other proper
>>> distributed filesystems using d_revalidate.
>> Huh?  We still need something like sysfs_get_dentry to find the dentries
>> for the rename or move operation.  So we can call d_move.  
> 
> Ah... right.  Thanks.  :-)

On the second thought, can't those too be dealt with d_revalidate?

-- 
tejun

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
