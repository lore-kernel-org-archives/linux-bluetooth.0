Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Apr 2009 19:16:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [2.6.29-git12] BUG: scheduling while atomic:
 swapper/0/0x10000100
In-Reply-To: <8db1092f0904100952x64048907gea6bbaf25488de26@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0904101854250.21577@localhost.localdomain>
References: <8db1092f0904070037q426fd8dcx4aa48c70e40b5d6c@mail.gmail.com>  <20090409212028.7b2aa88c.akpm@linux-foundation.org>  <8db1092f0904100340g7b7eb310y805e8680a32e3ac8@mail.gmail.com>  <alpine.LFD.2.00.0904101329170.21577@localhost.localdomain>
 <8db1092f0904100747w297a0daas9ebd05486d06e706@mail.gmail.com>  <alpine.LFD.2.00.0904101819070.21577@localhost.localdomain> <8db1092f0904100952x64048907gea6bbaf25488de26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 10 Apr 2009, Maciej Rutecki wrote:
> 2009/4/10 Thomas Gleixner <tglx@linutronix.de>:
> 
> >
> > Is this with my patch applied ?
> 
> Yes. I didn't observe any change.

Hmm. Ok, so the check in do_IRQ did not trigger. That means we need to
look for some other place.

Can you please apply the patch below and set CONFIG_FUNCTION_TRACER=y.
After boot please do as root:

# mount -t debugfs debugfs /sys/kernel/debug
# echo function >/sys/kernel/debug/tracing/current_tracer
# ech0 1 >/sys/kernel/debug/tracing/options/latency-format
# echo 1 >/sys/kernel/debug/tracing/tracing_enabled

Now wait until that scheduling while atomic bug triggers. This will
stop the tracer. Now

# cat /sys/kernel/debug/tracing/trace | bzip2 >/tmp/trace.bz2

Please upload trace.bz2 file to some place.

Thanks,

	tglx

----
diff --git a/kernel/sched.c b/kernel/sched.c
index 5724508..2e257bf 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4912,6 +4912,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 {
 	struct pt_regs *regs = get_irq_regs();
 
+	tracing_off();
 	printk(KERN_ERR "BUG: scheduling while atomic: %s/%d/0x%08x\n",
 		prev->comm, prev->pid, preempt_count());
 
