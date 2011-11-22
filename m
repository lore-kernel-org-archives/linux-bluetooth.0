Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Nov 2011 12:22:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add thermometer python script
Message-ID: <20111122102210.GA3490@fusion.localdomain>
References: <1321954439-6086-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321954439-6086-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Nov 22, 2011, Santiago Carot-Nemesio wrote:
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -215,8 +215,8 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
>  		test/test-input test/test-attrib test/test-proximity \
>  		test/test-sap-server test/test-oob test/test-serial-proxy \
>  		test/service-record.dtd test/service-did.xml \
> -		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
> -
> +		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
> +		test/test-thermometer

The idea is to have these ordered so that the tests come before the xml
files, i.e. add your test after test-serial-proxy.

> +	exit_on_release = True
> +
> +	def set_exit_on_release(self, exit_on_release):
> +		self.exit_on_release = exit_on_release

What's this for? Doesn't seem to be used anywhere.

> +	option_list = [
> +		make_option("-i", "--adapter", action="store",
> +			type="string", dest="adapter"),
> +		make_option("-b", "--device", action="store",
> +			type="string", dest="address"),
> +		]
> +
> +	parser = OptionParser(option_list=option_list)
> +
> +	(options, args) = parser.parse_args()
> +
> +	if options.adapter:
> +		adapter_path = manager.FindAdapter(options.adapter)
> +	else:
> +		adapter_path = manager.DefaultAdapter()
> +
> +	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
> +							"org.bluez.Adapter")
> +
> +	device_path = adapter.FindDevice(options.address)

I know you've probably just copied the options.address stuff from
test-proximity, but since the remote address is mandatory why not make
it a plain (non-switch) command line parameter. You're in any case
missing the check for whether it was provided or not which would
probably trigger an exception instead of a clean error message.

Johan
